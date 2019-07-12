var EnergyQuota = artifacts.require("EnergyQuota");
var EnergyConsumption = artifacts.require("EnergyConsumption");

module.exports = function(deployer, accounts) {
  deployer.deploy(EnergyQuota);
  deployer.deploy(EnergyConsumption);
};