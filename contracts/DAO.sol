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
        mapping(address => uint) prices;
        mapping(bytes3 => IERC20) tokens;
    }

    mapping(address => Partner) private _partners;
    mapping(address => address) private _coinsToPartner;

    constructor(string memory _name) {
        name = _name;
    }

    modifier onlyPartner() {
        require(_partners[msg.sender].referrer != address(0), "NOT_REGISTERED");
        _;
    }

    function buyToken(address _token) external payable returns(bool) {
        // mint
        address partner = address(_coinsToPartner[_token]);
        _partners[partner].balance += msg.value;
        // TODO: mint new tokens to buyer
        return true;
    }

    function setPrice(bytes3 _symbol, uint _price) external onlyPartner returns(bool) {
        address token = address(_partners[msg.sender].tokens[_symbol]);
        _partners[msg.sender].prices[token] = _price;
        // TODO: emit new event
        return true;
    }

    function register(address _referrer) external payable returns(bool) {
        require(_referrer != address(0), "REFERRER_REQUIRED");
        require(msg.value >= 1 ether, "NOT_ENOUGH_ETH");
        _partners[msg.sender].referrer = _referrer;
        _totalEth += msg.value;
        // TODO: pay to upline
        // TODO: emit new event
        return true;
    }

    function emitCoin(string memory _name, bytes3 _symbol, uint _price) external payable onlyPartner returns(bool) {
        require(msg.value >= 0.1 ether);
        assert(_totalEth + 0.1 ether > _totalEth);
        _totalEth += 0.1 ether;
        IERC20 coin = new ERC20(_name, string(abi.encodePacked(_symbol)), 18, msg.sender);
        _partners[msg.sender].tokens[_symbol] = coin;
        _partners[msg.sender].prices[address(coin)] = _price;
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


// 5U6ZBH