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
    return App.initContract();
  },

  initContract: function() {
    $.getJSON("EnergyQuota.json", function(energyQuota) {
      // Instantiate a new truffle contract from the artifact
      App.contracts.EnergyQuota = TruffleContract(energyQuota);
      // Connect provider to interact with contract
      App.contracts.EnergyQuota.setProvider(App.web3Provider);
      return App.render();

    });
    
  },

  render: function() {
    var energyQuotaInstance;
    var energyConsumptionInstance;
    var loader = $("#loader");
    var content = $("#content");

    loader.show();
    content.hide();

    // Load account data
    web3.eth.getAccounts(function(error, accounts) {
        console.log(accounts);
        App.account = accounts[0];
        $("#accountAddress").html("Your Account: " + App.account);
    });

    // Load contract data
    App.contracts.EnergyQuota.deployed().then(function(instance) {
      energyQuotaInstance = instance;
      energyQuotaInstance.addClient(10, App.account)
      return energyQuotaInstance.getQuotaBought(App.account);
    }).then(function(energyConsumed) {
      var candidatesResults = $("#candidatesResults");

      // Render candidate Result
      var candidateTemplate = "<tr><th>" + energyConsumed + "</th></tr>"
      candidatesResults.append(candidateTemplate);

      loader.hide();
      content.show();
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