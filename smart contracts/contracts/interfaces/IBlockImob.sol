// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "./IERC4907.sol";

interface IBlockImob is IERC4907 {
    function allowed(address _party) external view returns (bool);
}
