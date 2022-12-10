// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;


import "./interfaces/IBlockImob.sol";
import "./Fii.sol";


contract FiiManagement {
    IBlockImob blockImobContract;


    mapping (uint256 => address) public FiiAddress;


    event FiiCreated(uint256 indexed _type, address indexed _address);

    constructor(address _blockImob) {
        blockImobContract = IBlockImob(_blockImob);
    }

    modifier onlyAllowed() {
        require(blockImobContract.returnAllowed(msg.sender), "Fii Management: Not allowed");
        _;
    }

    function createFii(uint256 _type) external onlyAllowed{
        require(FiiAddress[_type] == address(0),"Fii Management: Fii type already have a valid address");

        Fii fii = new Fii();

        FiiAddress[_type] = address(fii);

        emit FiiCreated(_type, address(fii));
    }

    function killFii(uint256 _type) external onlyAllowed{
        require(FiiAddress[_type] != address(0),"Fii Management: Fii type doesn't have a valid address");

        
    }


}
