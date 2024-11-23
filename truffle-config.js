module.exports = {
  networks: {
    development: {
      host: "127.0.0.1", // Localhost (default Ganache)
      port: 8545,        // Ganache's port
      network_id: "*",   // Match any network id
    },
  },
  compilers: {
    solc: {
      version: "0.8.0", // Match your Solidity version
    },
  },
};



