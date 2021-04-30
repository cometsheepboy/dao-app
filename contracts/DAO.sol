// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

import "./IERC20.sol";
import "./ERC20.sol";

contract DAO {
    string public name;
    uint private _totalEth;
    
    struct Partner {
        address referrer;
        uint balance;
        mapping(address => uint) price;
        mapping(bytes3 => IERC20) tokens;
    }

    mapping(address => Partner) private _partners;

    constructor(string memory _name) {
        name = _name;
    }

    modifier onlyPartner() {
        require(_partners[msg.sender].referrer != address(0), "NOT_REGISTERED");
        _;
    }

    function register(address _referrer) external payable returns(bool) {
        require(_referrer != address(0), "REFERRER_REQUIRED");
        require(msg.value >= 1 ether, "NOT_ENOUGH_ETH");
        _partners[msg.sender].referrer = _referrer;
        _totalEth += msg.value;
        return true;
    }

    function emitCoin(string memory _name, bytes3 _symbol) external payable onlyPartner returns(bool) {
        require(msg.value >= 0.1 ether);
        assert(_totalEth + 0.1 ether > _totalEth);
        _totalEth += 0.1 ether;
        _partners[msg.sender].tokens[_symbol] = new ERC20(_name, string(abi.encodePacked(_symbol)), 18, msg.sender);
        return true;
    }
    
    receive() external payable {

    }

    fallback() external payable {

    }
}

// every partner can emit it own currency and set price for it
// part of ownership based on part of ether received for selling coins
// partners can exchange coins between themselves
