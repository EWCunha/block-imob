// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "./ERC20.sol";
import "./interfaces/IERC20.sol";
import "./interfaces/IBlockImob.sol";

contract Fii is ERC20{


    IBlockImob blockImobContract;

    address immutable gov;

    IERC20 constant paymentToken =
        IERC20(0xC5375c73a627105eb4DF00867717F6e301966C32);

    uint256 public sharePrice;
    uint256 public totalShares;

    constructor(string memory _name, string memory _symbol, uint8 _decimals, address _blockImob, address _gov) ERC20(_name,_symbol,_decimals) {
        blockImobContract = IBlockImob(_blockImob) ;
        gov = _gov;
    }


    modifier onlyAllowed() {
        require(blockImobContract.returnAllowed(msg.sender), "Fii: Not allowed");
        _;
    }



    function mintShare(uint256 _amount) external {
        require(totalSupply + _amount <= totalShares, "Fii: Can't mint more shares");
        require(paymentToken.balanceOf(msg.sender) >= sharePrice*_amount, "Fii: Not enough tokens to buy");
        require(paymentToken.allowance(msg.sender, address(this)) >= sharePrice*_amount, "Fii: Allowance not enough");

        bool success = transferFrom(msg.sender, address(this), sharePrice);
        require(success, "Fii: Purchase Transfer Failed");

        _mint(msg.sender, _amount);

    }

    function killFii() onlyAllowed external {
        transfer(gov, paymentToken.balanceOf(address(this)));
        selfdestruct(payable(gov));
    } 



    
}