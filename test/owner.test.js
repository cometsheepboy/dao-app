const Owner = artifacts.require("./Owner.sol");
contract("Owner", accounts => {
  it("base account[0] should be in owner history", async () => {
    const OwnerInstance = await Owner.deployed();
    const {
      logs: [log]
    } = await OwnerInstance.getOwnerHistory();
    const {args} = log;
    assert.equal(args._history[0], accounts[0], "Msg.sender should be owner of contract");
  });
});
