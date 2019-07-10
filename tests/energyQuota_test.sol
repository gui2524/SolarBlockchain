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
    uint percentageQuota = 10;
    quotaToTest.setValueBought(percentageQuota, msg.sender);
    Assert.equal(percentageQuota, quotaToTest.getValueBought(msg.sender), "Percentage Bougth different ");
  }
  
  function check2() public{
    quotaToTest.setValueBought(10, msg.sender);
    consumptionToTest.setEnergyConsumed(5, msg.sender);
    Assert.equal(5, consumptionToTest.checkEnergyCredit(msg.sender), "Check energy different ");
    consumptionToTest.setEnergyConsumed(10, msg.sender);
    Assert.equal(0, consumptionToTest.checkEnergyCredit(msg.sender), "Check energy different ");
    consumptionToTest.setEnergyConsumed(15, msg.sender);
    Assert.equal(-5, consumptionToTest.checkEnergyCredit(msg.sender), "Check energy different ");
  }
}



