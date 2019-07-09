pragma solidity >=0.4.22 <0.6.0;
import "remix_tests.sol"; // this import is automatically injected by Remix.
import "./solarInfo.sol";

// file name has to end with '_test.sol'
contract test_1 {

  EnergyQuota quotaToTest;
  
  function beforeAll() public {
    quotaToTest = new EnergyQuota();
  }
 
  function check1() public {
    uint percentageQuota = 10;
    address myAddress = 0xE0f5206BBD039e7b0592d8918820024e2a7437b9;
    quotaToTest.setValueBought(percentageQuota, myAddress);
    Assert.equal(percentageQuota, quotaToTest.getValueBought(myAddress), "Percentage Bougth different ");
  }
}
