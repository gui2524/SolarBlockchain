pragma solidity >=0.4.22 <0.6.0;

contract EnergyQuota{
    //uint percentageBought = 0;
    
    struct Quota{
        uint percentageBought;
    }
    
    mapping (uint => Quota) clients
    
    
    
}