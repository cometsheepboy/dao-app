// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

contract Owner {

    address public owner;
    address[] private _ownerHistory;

    event OwnerChanged(address indexed _from, address indexed _to);
    event OwnerHistory(address[] _history);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(_isOwner(), "MOD_ONLY_OWNER");
        _;
    }

    function getOwnerHistory() external {
        emit OwnerHistory(_ownerHistory);
    }

    function setOwner(address _newOwner) external onlyOwner {
        owner = _newOwner;
        _ownerHistory.push(_newOwner);
        emit OwnerChanged(msg.sender, _newOwner);
    }

    function _isOwner() internal view returns(bool) {
        return msg.sender == owner;
    }
    
}