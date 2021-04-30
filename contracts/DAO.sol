// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

import "./IERC20.sol";
import "./ERC20.sol";

contract DAO {
    string private _name;
    uint private _totalEth;
    
    struct Partner {
        IERC20 token;
        address referrer;
        uint balance;
        mapping(address => uint) price;
    }

    constructor(string memory name_) {
        _name = name_;
    }
    
    receive() external payable {

    }

    fallback() external payable {

    }
}

// every partner can emit it own currency and set price for it
// part of ownership based on part of ether received for selling coins
// partners can exchange coins between themselves
