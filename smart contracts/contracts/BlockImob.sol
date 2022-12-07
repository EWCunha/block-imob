// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "./ERC4907.sol";

contract BlockImob is ERC4907 {
    enum DealType {
        RENT,
        SELL
    }

    struct Deal {
        DealType dealType;
        address dealAddress;
        address fiiAddress;
    }

    struct Query {
        string district;
        uint256 registry;
    }

    mapping(address => bool) public allowed;
    mapping(uint256 => string) public tokenIdToURI;
    mapping(uint256 => Deal) public tokenIdToDeal;
    mapping(string => mapping(uint256 => uint256)) public queryToTokenId;
    mapping(uint256 => Query) public tokenIdToQuery;
    string public baseURI;
    uint256 public nextTokenId = 1; // 0 for token no longer active

    event UpdatedTokenURI(
        uint256 indexed tokenId,
        string indexed newURI,
        string newURIText
    );
    event UpdatedBaseURI(string indexed newBaseURI, string newBaseURIText);
    event UpdatedTokenDeal(
        uint256 indexed tokenId,
        DealType dealType,
        address indexed dealAddress,
        address indexed fiiAddress
    );

    constructor(string memory _name, string memory _symbol)
        ERC4907(_name, _symbol)
    {
        allowed[msg.sender] = true;
    }

    modifier onlyAllowed() {
        require(allowed[msg.sender], "BlockImob: Not allowed");
        _;
    }

    modifier validateTokenId(uint256 _tokenId) {
        require(_tokenId < nextTokenId, "BlockImob: Invalid tokenId");
        _;
    }

    modifier validateURI(string memory _uri) {
        require(bytes(_uri).length > 0, "BlockImob: No URI given");
        _;
    }

    function mint(
        address _owner,
        string memory _uri,
        string memory _district,
        uint256 _registry
    ) external virtual onlyAllowed validateURI(_uri) {
        require(bytes(_district).length > 0, "BlockImob: No district given");
        require(_registry > 0, "BlockImob: Invalid registry given");
        uint256 tokenId = nextTokenId;

        unchecked {
            nextTokenId++;
        }

        tokenIdToURI[tokenId] = _uri;
        queryToTokenId[_district][_registry] = tokenId;
        tokenIdToQuery[tokenId] = Query(_district, _registry);

        _safeMint(_owner, tokenId);
    }

    function burn(uint256 _tokenId)
        external
        onlyAllowed
        validateTokenId(_tokenId)
    {
        delete tokenIdToURI[_tokenId];
        Query memory query = tokenIdToQuery[_tokenId];
        delete queryToTokenId[query.district][query.registry];
        delete tokenIdToQuery[_tokenId];
        delete tokenIdToDeal[_tokenId];

        _burn(_tokenId);
    }

    function updateTokenDeal(
        uint256 _tokenId,
        DealType _dealType,
        address _dealAddress,
        address _fiiAddress
    ) external onlyAllowed validateTokenId(_tokenId) {
        tokenIdToDeal[_tokenId].dealType = _dealType;
        tokenIdToDeal[_tokenId].dealAddress = _dealAddress;
        tokenIdToDeal[_tokenId].fiiAddress = _dealType == DealType.SELL
            ? address(0)
            : _fiiAddress;

        emit UpdatedTokenDeal(_tokenId, _dealType, _dealAddress, _fiiAddress);
    }

    function setBaseURI(string memory _newBaseURI) external onlyAllowed {
        baseURI = _newBaseURI;
        emit UpdatedBaseURI(_newBaseURI, _newBaseURI);
    }

    function setTokenURI(uint256 _tokenId, string memory _uri)
        external
        onlyAllowed
        validateTokenId(_tokenId)
        validateURI(_uri)
    {
        tokenIdToURI[_tokenId] = _uri;
        emit UpdatedTokenURI(_tokenId, _uri, _uri);
    }

    function tokenURI(uint256 _tokenId)
        public
        view
        override
        validateTokenId(_tokenId)
        returns (string memory)
    {
        return (
            bytes(baseURI).length == 0
                ? tokenIdToURI[_tokenId]
                : string(abi.encodePacked(baseURI, _tokenId, ".json"))
        );
    }

    // function tokenIdFromQuery(string memory _district, uint256 _registry)
    //     external
    //     view
    //     returns (uint256)
    // {
    //     return queryToTokenId[_district][_registry];
    // }

    // function queryFromTokenId(uint256 _tokenId)
    //     external
    //     view
    //     validTokenId(_tokenId)
    //     returns (Query memory)
    // {
    //     return tokenIdToQuery[_tokenId];
    // }
}
