pragma solidity >=0.4.22 <0.6.0;

contract EnergyQuota{
    
    struct Quota{
        int quotaBought;
    }
    
    mapping (address => Quota) clients;
    
    function addClient(int _quotaBought, address _client) public{
        clients[_client].quotaBought = _quotaBought;
    }
    
    function getQuotaBought(address _client) public view returns (int _quotaBought){
        return clients[_client].quotaBought;
    }
}

contract EnergyConsumption{
    
    EnergyQuota quota;
    
    struct Client{
        int energyConsumed;
        int energyCredit;
        int energyToBePaid;
    }
    
    mapping (address => Client) clients;
    
    constructor (address _t) public {
        quota = EnergyQuota(_t);
    }
     
    function addClient(int _energyConsumed, address _client) public{
        clients[_client].energyConsumed = _energyConsumed;
        clients[_client].energyToBePaid = 0;
        clients[_client].energyCredit = 0;
    }
    
    function manageConsumption(address _client) public{
        int credit = quota.getQuotaBought(_client) - clients[_client].energyConsumed;
        int toBePaid = clients[_client].energyConsumed- quota.getQuotaBought(_client);
       
        clients[_client].energyCredit = (credit > 0) ? credit : 0;
        clients[_client].energyToBePaid = (toBePaid > 0) ? toBePaid : 0;
    }
    
    function getEnergyConsumed(address _client) public view returns (int _energyConsumed){
        return clients[_client].energyConsumed;
    }
    
    function getEnergyCredit(address _client) public view returns (int _energyCredit){
        return clients[_client].energyCredit;
    }
    
    function getEnergyToBePaid(address _client) public view returns (int _energyToBePaid){
        return clients[_client].energyToBePaid;
    }   
}