// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

import "./IERC20.sol";
import "./ERC20.sol";
import "./Owner.sol";

contract DAOToken is ERC20 {
    constructor(string memory _name, string memory _symbol, uint8 _decimals) ERC20(_name, _symbol, _decimals) {}
}

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

    event NewUser(address indexed _referral, address indexed _referrer);
    event TokenCreated(address indexed _owner, address indexed _coin, string _symbol, uint _price);

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

    function register(address _referrer) external payable returns(bool) {
        require(_referrer != address(0), "REFERRER_REQUIRED");
        require(msg.value >= 1000, "NOT_ENOUGH_ETH");
        _partners[msg.sender].referrer = _referrer;
        _totalEth += msg.value;
        // TODO: pay to upline
        emit NewUser(msg.sender, _referrer);
        return true;
    }

    function createToken(string memory _name, string memory _symbol, uint _price) external payable onlyPartner {
        require(msg.value >= 100);
        assert(_totalEth + 100 > _totalEth);
        ERC20 coin = new ERC20(_name, _symbol, 18);
        _coinOwners[address(coin)].owner = msg.sender;
        _coinOwners[address(coin)].price = _price;
        emit TokenCreated(msg.sender, address(coin), _symbol, _price);
    }
    
    function buyToken(address _coin) external payable {
        ERC20 ctr = ERC20(_coin);
        ctr._mint();
    }
    
    function buyToken(string memory _symbol) external payable {
        
    }
    
    receive() external payable {

    }

    fallback() external payable {

    }
}

// every partner can emit it own currency and set price for it
// part of ownership based on part of ether received for selling coins
// partners can exchange coins between themselves
