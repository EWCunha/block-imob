require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: {
    version: "0.8.17",
    settings: {
      optimizer: {
        enabled: true,
        runs: 1000,
      },
    },
  },
  networks: {
    // testnet: {
    //   url: process.env.TESTNET_RPC,
    //   accounts: [process.env.PRIVATE_KEY]
    // }
  }
};
