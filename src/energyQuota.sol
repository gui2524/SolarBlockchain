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