// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "./ERC4907.sol";

contract BlockImob is ERC4907 {
    mapping(address => bool) public allowed;
    mapping(uint256 => bytes) public CID;
    mapping(uint256 => bool) public tokenUsed;

    constructor(string memory _name, string memory _symbol)
        ERC4907(_name, _symbol)
    {
        allowed[msg.sender] = true;
    }

    modifier onlyAllowed() {
        require(allowed[msg.sender], "BlockImob: Not allowed");
        _;
    }

    function mint(
        uint256 _tokenId,
        string memory _cid,
        address _owner
    ) external onlyAllowed {
        require(!tokenUsed[_tokenId], "BlockImob: TokenID taken");
        bytes memory cid = bytes(_cid);
        require(cid.length > 0, "BlockImob: No CID given");

        tokenUsed[_tokenId] = true;
        CID[_tokenId] = cid;

        _safeMint(_owner, _tokenId);
    }

    function sell(uint256 _tokenId, address _buyer) external onlyAllowed {}

    function rent(uint256 _tokenId, address _renter) external onlyAllowed {}

    function tokenURI(uint256 _id)
        public
        view
        override
        returns (string memory)
    {
        return string(CID[_id]);
    }
}
