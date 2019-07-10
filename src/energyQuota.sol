pragma solidity >=0.4.22 <0.6.0;

contract EnergyQuota{
    //uint percentageBought = 0;
    
    struct Quota{
        uint valueBougth;
    }
    
    mapping (address => Quota) clients;
    
    //constructor (uint _percentageBought) public{
      //  clients[msg.sender].percentageBought = _percentageBought;
    //}
    
    function setValueBought(uint _valueBougth, address _client) public{
        //TODO: Quem pode setar esse dado? Seria necessario um owner? deveria apenas o msg.sender poder setar o seu percentageBought?
        //clients[msg.sender].percentageBought = _percentageBought;
        clients[_client].valueBougth = _valueBougth;
    }
    
    function getValueBought(address _client) public view returns (uint _percentageBought){
        //TODO: Verificacao de quem pode pegar esse dado?
        return clients[_client].valueBougth;
    }
    
}

contract EnergyConsumption{
    
    EnergyQuota quota;
    
    struct Client{
        uint energyConsumed;
    }
    
    mapping (address => Client) clients;
    
    constructor (address _t) public {
        quota = EnergyQuota(_t);
    }
    
    function debit(address _client, uint energy) public{
        
    }
    
    function credit(address _client, uint energy) public{
        
    }
     
    function setEnergyConsumed(uint _energyConsumed, address _client) public{
        //TODO: Quem pode setar esse dado? Seria necessario um owner? deveria apenas o msg.sender poder setar o seu percentageBought?
        clients[_client].energyConsumed = _energyConsumed;
    }
    
    function checkEnergyCredit(address _client) public returns (int _energyCredit){
        //TODO: Verificacao de quem pode pegar esse dado?
        //if(clients[_client].energyConsumed <= 0){
         //   log1(bytes32(uint256(_client)), bytes32(clients[_client].energyConsumed));
          //  return int(quota.getValueBought(_client));
       // }
        
        //if(quota.getValueBought(_client) <= 0){
          //  log1(bytes32(uint256(_client)), bytes32(quota.getValueBought(_client)));
            //debit?
            //return 0;
        //}
        
        //log2(bytes32(uint256(_client)), bytes32(quota.getValueBought(_client)), bytes32(clients[_client].energyConsumed));
        return int(quota.getValueBought(_client) - clients[_client].energyConsumed);
    }
    
    function manageConsumption(address _client) public{
        int energyCredit = checkEnergyCredit(_client);
        
        if(energyCredit > 0){
            credit(_client, uint(energyCredit));
        }
        else if (energyCredit < 0){
            int energyValue = 0;
            energyValue -= energyCredit;
            debit(_client, uint(energyValue));
        }
        else{
            
        }
    }
    
    
    
    
    
}