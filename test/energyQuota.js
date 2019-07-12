var EnergyQuota = artifacts.require("EnergyQuota");
var EnergyConsumption = artifacts.require("EnergyConsumption");

var energyQuotaInstance;

contract("EnergyQuota", function(accounts) {

  it("Initialize a client with 10 quota bought", function() {
    return EnergyQuota.deployed().then(function(instance) {
      energyQuotaInstance = instance;
      instance.addClient(10, accounts[0])
      return instance.getQuotaBought(accounts[0]);
    }).then(function(count) {
      assert.equal(count, 10);
    });
  });

  it("Initialize a client with 2 energy consumed", function() {
    return EnergyConsumption.deployed().then(function(instance) {
      instance.addClient(2, accounts[0])
      return instance.getEnergyConsumed(accounts[0]);
    }).then(function(count) {
      assert.equal(count, 2);
    });
  });

  it("Test energy credit", function() {
    return EnergyConsumption.deployed().then(function(instance) {
      return instance.getEnergyCredit(accounts[0]);
    }).then(function(count) {
      assert.equal(count, 0);
    });
  });

  it("Test energy manage", function() {
    return EnergyConsumption.deployed().then(function(instance) {
      instance.manageConsumption(accounts[0], energyQuotaInstance.address);
      return instance.getEnergyCredit(accounts[0]);
    }).then(function(count) {
      assert.equal(count, 8);
    });
  });

});
