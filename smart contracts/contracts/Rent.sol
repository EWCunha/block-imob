// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "./interfaces/IBlockImob.sol";
import "./interfaces/IERC20.sol";

contract Rent {
    IBlockImob public immutable blockImob;
    address public immutable renter;
    address public immutable gov;
    uint256 public immutable tokenId;
    uint256 public expires;
    uint256 public price;
    IERC20 constant paymentToken =
        IERC20(0xC5375c73a627105eb4DF00867717F6e301966C32);
    mapping(uint256 => bool) public monthPaid;

    event MonthPaid(uint256 indexed month);
    event RentEnded(address indexed _party);

    constructor(
        address _renter,
        address _gov,
        uint256 _tokenId,
        uint256 _expires,
        uint256 _price
    ) {
        renter = _renter;
        gov = _gov;
        tokenId = _tokenId;
        expires = _expires;
        price = _price;
        blockImob = IBlockImob(msg.sender);
    }

    function payRent(uint256 _month) external payable {
        require(msg.sender == renter, "Rent: Not renter");
        require(
            !(paymentToken.allowance(msg.sender, address(this)) < price),
            "Rent: Insuficient allowance"
        );
        require(!monthPaid[_month], "Rent: Month paid");

        monthPaid[_month] = true;
        paymentToken.transferFrom(msg.sender, gov, price);

        emit MonthPaid(_month);
    }

    function endRent() external {
        if (!blockImob.allowed(msg.sender)) {
            uint256 months = expires / 30 days + 1;

            for (uint256 i = 1; i < months; ++i) {
                if (!monthPaid[i]) {
                    revert("Rent: Month(s) not paid");
                }
            }
        }

        emit RentEnded(msg.sender);
        selfdestruct(payable(gov));
    }
}
