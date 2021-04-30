// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Owner.sol";

contract TestOwner {

  function testItOwnerAddress() public {
    Owner ownerContract = Owner(DeployedAddresses.Owner());
    address current = ownerContract.owner.address;
    Assert.equal(current, DeployedAddresses.Owner(), "Should be contract owner");
  }

}
