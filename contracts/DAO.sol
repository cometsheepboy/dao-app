// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

import "./IERC20.sol";
import "./ERC20.sol";
import "./Owner.sol";

contract DAO is Owner {
    string public name;
    uint private _totalEth;
    
    struct Partner {
        address referrer;
        uint balance;
    }

    struct Coin {
        address owner;
        uint price;
    }

    mapping(address => Partner) private _partners;
    mapping(address => Coin) private _coinOwners;

    constructor(string memory _name) {
        name = _name;
    }

    modifier onlyPartner() {
        require(_partners[msg.sender].referrer != address(0), "NOT_REGISTERED");
        _;
    }

    modifier onlyCoinOwner(address _coin) {
        require(_coinOwners[_coin].owner == msg.sender);
        _;
    }

    // function buyToken(address _token) external payable returns(bool) {
    //     // mint
    //     address partner = address(_coinsToPartner[_token]);
    //     _partners[partner].balance += msg.value;
    //     // TODO: mint new tokens to buyer
    //     return true;
    // }

    // function setCoinPrice(bytes3 _symbol, uint _price) external onlyPartner returns(bool) {
    //     address token = address(_partners[msg.sender].tokens[_symbol]);
    //     _partners[msg.sender].prices[token] = _price;
    //     // TODO: emit new event
    //     return true;
    // }


    function mint(address _coin) external payable onlyPartner onlyCoinOwner(_coin) returns(bool) {
        assert(_partners[msg.sender].balance + msg.value > _partners[msg.sender].balance);
        _partners[msg.sender].balance += msg.value;
        uint amount = msg.value / _coinOwners[_coin].price;
        ERC20 ctr = ERC20(_coin);
        ctr.mint(msg.sender, amount);
        return true;
    }

    function register(address _referrer) external payable returns(bool) {
        require(_referrer != address(0), "REFERRER_REQUIRED");
        require(msg.value >= 1000, "NOT_ENOUGH_ETH");
        _partners[msg.sender].referrer = _referrer;
        _totalEth += msg.value;
        // TODO: pay to upline
        // TODO: emit new event
        return true;
    }

    function emitToken(string memory _name, bytes3 _symbol, uint _price) external payable onlyPartner returns(bool) {
        require(msg.value >= 100);
        assert(_totalEth + 100 > _totalEth);
        _totalEth += 100;
        IERC20 coin = new ERC20(_name, string(abi.encodePacked(_symbol)), 18, msg.sender);
        _coinOwners[address(coin)].owner = msg.sender;
        _coinOwners[address(coin)].price = _price;
        // TODO: emit event new token added
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
