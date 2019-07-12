App = {
  web3Provider: null,
  contracts: {},
  account: '0x0',

  init: function() {
    return App.initWeb3();
  },

  initWeb3: function() {
    if (typeof web3 !== 'undefined') {
      // If a web3 instance is already provided by Meta Mask.
      App.web3Provider = web3.currentProvider;
      web3 = new Web3(web3.currentProvider);
    } else {
      // Specify default instance if no web3 instance provided
      App.web3Provider = new Web3.providers.HttpProvider('http://localhost:7545');
      web3 = new Web3(App.web3Provider);
    }
    App.initContract();
  },

  initContract: function() {
    $.getJSON("EnergyConsumption.json", function(energyConsumption) {
      // Instantiate a new truffle contract from the artifact
      App.contracts.EnergyConsumption = TruffleContract(energyConsumption);
      // Connect provider to interact with contract
      App.contracts.EnergyConsumption.setProvider(App.web3Provider);
          $.getJSON("EnergyQuota.json", function(energyQuota) {
      // Instantiate a new truffle contract from the artifact
          App.contracts.EnergyQuota = TruffleContract(energyQuota);
      // Connect provider to interact with contract
          App.contracts.EnergyQuota.setProvider(App.web3Provider);

          App.render(10);

      });

    });
    
  },

  render: function() {
    var energyQuotaInstance;
    var energyConsumptionInstance;
    var loader = $("#loader");
    var content = $("#content");
    var ID;
    var energyConsumed;
    var quota;
    var totalToBePaid;
    var energyCredit;

    loader.show();
    content.hide();
 
    // Load account data
    web3.eth.getAccounts(function(error, accounts) {
        console.log(accounts);
        App.account = accounts[0];
        $("#accountAddress").html("Your Account: " + App.account);
    });

    App.contracts.EnergyConsumption.deployed().then(function(instance) {
      energyConsumptionInstance = instance;
      ID = window.prompt("Enter your LIGHT account ID: ");
      amount = window.prompt("Enter your amount of energy quota bought: ");
      if(ID == "Guilherme"){
        energyConsumptionInstance.addClient(100, App.account)
      }else if(ID == "Tamires"){
        energyConsumptionInstance.addClient(50, App.account)
      }else{
        energyConsumptionInstance.addClient(20, App.account)
      }
      
      return energyConsumptionInstance.getEnergyConsumed(App.account);
    }).then(function(_energyConsumed) {
      energyConsumed = _energyConsumed;

      App.contracts.EnergyQuota.deployed().then(function(instance) {
      energyQuotaInstance = instance;
      
      energyQuotaInstance.addClient(parseInt(amount), App.account);
      
      return energyQuotaInstance.getQuotaBought(App.account);
      }).then(function(_quota) {
        quota = _quota;
        energyConsumptionInstance.manageConsumption(App.account, energyQuotaInstance.address);
        return energyConsumptionInstance.getEnergyCredit(App.account);
          }).then(function(_energyCredit) {
            energyCredit =  _energyCredit
            return energyConsumptionInstance.getEnergyToBePaid(App.account);
          }).then(function(_energyToBePaid) {
              totalToBePaid = _energyToBePaid

              console.log(energyCredit);
              var candidatesResults = $("#candidatesResults");
              candidatesResults.empty();

            // Render candidate Result
              var candidateTemplate = "<tr><th>" + ID + "</th><td>" + totalToBePaid + "</td><td>" + energyCredit + "</td><td>" + energyConsumed + "</td><td>" + quota + "</td></tr>"
              candidatesResults.append(candidateTemplate);

              loader.hide();
              content.show();

      }).catch(function(error) {
        console.warn(error);
      });

    }).catch(function(error) {
      console.warn(error);
    });



    
  }
};

$(function() {
  $(window).load(function() {
    App.init();
  });
});