// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

contract ERC20 {
    string private _name;
    string private _symbol;
    uint8 private _decimals;
    uint private _totalSupply;
    
    mapping(address => uint) private _balances;
    
    constructor(string memory name_, string memory symbol_, uint8 decimals_) {
        _name = name_;
        _symbol = symbol_;
        _decimals = decimals_;
    }
    
    function symbol() public view returns(string memory) {
        return _symbol;
    }
    
    function decimals() public view returns (uint8) {
        return _decimals;
    }
    
    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }
    
    function balanceOf(address _owner) public view returns (uint256 balance) {
        return _balances[_owner];
    }
    
    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(_balances[msg.sender] >= _value, "NOT_ENOUGH_FUNDS");
        assert(_balances[msg.sender] > _balances[msg.sender] - _value);
        assert(_balances[_to] + _value > _balances[_to]);
        _balances[msg.sender] -= _value;
        _balances[_to] += _value;
        return true;
    }
}
