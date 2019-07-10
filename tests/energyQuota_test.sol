pragma solidity >=0.4.22 <0.6.0;
import "remix_tests.sol"; // this import is automatically injected by Remix.
import "./solarInfo.sol";

// file name has to end with '_test.sol'
contract test_1 {

  EnergyQuota quotaToTest;
  EnergyConsumption consumptionToTest;
  
  function beforeAll() public {
    quotaToTest = new EnergyQuota();
    consumptionToTest = new EnergyConsumption(address(quotaToTest));
  }
 
  function check1() public {
    int quota = 10;
    quotaToTest.addClient(quota, msg.sender);
    Assert.equal(quota, quotaToTest.getQuotaBought(msg.sender), "Percentage Bougth different ");
  }
  
  function check2() public{
    quotaToTest.addClient(10, msg.sender);
    consumptionToTest.addClient(5, msg.sender);
    consumptionToTest.manageConsumption(msg.sender);
    Assert.equal(5, consumptionToTest.getEnergyConsumed(msg.sender), "Error");
    Assert.equal(5, consumptionToTest.getEnergyCredit(msg.sender), "Error");
    Assert.equal(0, consumptionToTest.getEnergyToBePaid(msg.sender), "Error");
    
    consumptionToTest.addClient(10, msg.sender);
    consumptionToTest.manageConsumption(msg.sender);
    Assert.equal(10, consumptionToTest.getEnergyConsumed(msg.sender), "Error");
    Assert.equal(0, consumptionToTest.getEnergyCredit(msg.sender), "Error");
    Assert.equal(0, consumptionToTest.getEnergyToBePaid(msg.sender), "Error");
    
    consumptionToTest.addClient(15, msg.sender);
    consumptionToTest.manageConsumption(msg.sender);
    Assert.equal(15, consumptionToTest.getEnergyConsumed(msg.sender), "Error");
    Assert.equal(0, consumptionToTest.getEnergyCredit(msg.sender), "Error");
    Assert.equal(5, consumptionToTest.getEnergyToBePaid(msg.sender), "Error");
  }
}



