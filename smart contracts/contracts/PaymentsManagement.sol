// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "./Sell.sol";
import "./Rent.sol";
import "./interfaces/IBlockImob.sol";

contract PaymentsManagement {
    IBlockImob blockImobContract;

    constructor(address _blockImob) {
        blockImobContract = IBlockImob(_blockImob);
    }

    modifier onlyAllowed() {
        require(blockImobContract.allowed(msg.sender), "PayM: Not allowed");
        _;
    }

    function sellToken(
        uint256 _tokenId,
        address _from,
        address _to,
        address _moderatorFrom,
        address _moderatorTo,
        uint256 _amount
    ) external onlyAllowed {}

    function rentToken(
        uint256 _tokenId,
        address _renter,
        uint256 _expires,
        uint256 _rentPrice
    ) external onlyAllowed {}
}
