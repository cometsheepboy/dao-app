// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

interface IReferral {
    function register(address _referrer) external view returns (string memory);
}