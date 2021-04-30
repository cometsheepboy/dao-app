// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

contract DAO {
    string private _name;

    constructor() {

    }

    function name() external view returns(string memory) {
        return _name;
    }

    
    receive() external payable {

    }
    fallback() external payable {

    }
}