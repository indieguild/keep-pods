var Registry = artifacts.require("./Registry.sol");
var sKEEP = artifacts.require("./sKEEP.sol");
var StakingPool = artifacts.require("./StakingPool.sol");


module.exports = function(deployer) {
  deployer.deploy(Registry);
};
module.exports = function(deployer) {
    deployer.deploy(sKEEP);
};
module.exports = function(deployer) {
deployer.deploy(StakingPool);
};
    