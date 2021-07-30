var PKTFactory = artifacts.require("./PKTFactory.sol");

module.exports = function(deployer,network,accounts) {
  await deployer.deploy(PKTFactory);
};
