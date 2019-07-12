pragma solidity >=0.4.22 <0.6.0;

contract EnergyQuota{
    
    struct Quota{
        int quotaBought;
    }
    
    mapping (string => Quota) clients;
    
    function addClient(int _quotaBought, string memory _client) public{
        clients[_client].quotaBought = _quotaBought;
    }
    
    function getQuotaBought(string memory _client) public view returns (int _quotaBought){
        return clients[_client].quotaBought;
    }
}

contract EnergyConsumption{

    
    struct Client{
        int energyConsumed;
        int energyCredit;
        int energyToBePaid;
    }
    
    mapping (string => Client) clients;
    
     
    function addClient(int _energyConsumed, string memory _client) public{
        clients[_client].energyConsumed = _energyConsumed;
        clients[_client].energyToBePaid = 0;
        clients[_client].energyCredit = 0;
    }
    
    function manageConsumption(string memory _client, address _contract) public{
        int credit = EnergyQuota(_contract).getQuotaBought(_client) - clients[_client].energyConsumed;
        int toBePaid = clients[_client].energyConsumed- EnergyQuota(_contract).getQuotaBought(_client);
       
        clients[_client].energyCredit = (credit > 0) ? credit : 0;
        clients[_client].energyToBePaid = (toBePaid > 0) ? toBePaid : 0;
    }
    
    function getEnergyConsumed(string memory _client) public view returns (int _energyConsumed){
        return clients[_client].energyConsumed;
    }
    
    function getEnergyCredit(string memory _client) public view returns (int _energyCredit){
        return clients[_client].energyCredit;
    }
    
    function getEnergyToBePaid(string memory _client) public view returns (int _energyToBePaid){
        return clients[_client].energyToBePaid;
    }   
}