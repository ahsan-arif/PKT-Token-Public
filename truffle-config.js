const path = require("path");
var HDWalletProvider = require("@truffle/hdwallet-provider");
const infuraKey = "INFURA_KEY_PLACED;"
const fs = require('fs');
const mnemonic = fs.readFileSync(".secret").toString().trim();

module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!
  contracts_build_directory: path.join(__dirname, "client/src/contracts"),
  networks: {
    development: {
      host : "127.0.0.1",
      port: 7545,
      network_id : "*"
    },
    ropsten :{
      provider: function() {
        return new HDWalletProvider(mnemonic, "https://ropsten.infura.io/v3/d727f2046b3c42e3931fd0ac2b8e2184")
      },
      network_id: 3,
      networkCheckTimeout: 10000000,
      confirmations: 2,
      timeoutBlocks: 200,  // # of blocks before a deployment times out  (minimum/default: 50)
      skipDryRun: true ,
      gas: 5500000      //make sure this gas allocation isn't over 4M, which is the max
    }
  },
  contracts_directory: './contracts/',
  contracts_build_directory: './client/src/contracts/',
  compilers: {
    solc: {
      version: "^0.8.5"
    }
  }
};
