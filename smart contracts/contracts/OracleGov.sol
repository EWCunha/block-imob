// // SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "./interfaces/IGovDataReference.sol";

contract OracleGov {
    IGovDataReference govData;

    mapping(address => bool) AllowedGov;

    constructor(IGovDataReference _govData) {
        govData = _govData;
    }
}
