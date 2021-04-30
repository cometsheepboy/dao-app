// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.21 <0.7.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Owner.sol";

contract TestOwner {

  function testItOwnerAddress() public {
    Owner ownerContract = Owner(DeployedAddresses.Owner());
    address current = address(ownerContract.owner);
    Assert.equal(current, DeployedAddresses.Owner(), "Should be contract owner");
  }

}
