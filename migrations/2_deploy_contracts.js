var PKTFactory = artifacts.require("./PKTFactory.sol");

module.exports =async function(deployer,network,accounts) {
  await deployer.deploy(PKTFactory);
};
