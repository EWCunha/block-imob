require("@nomicfoundation/hardhat-toolbox");
require("hardhat-celo");

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
    hardhat: {
    //},
    // alfajores: {
    //   // can be replaced with the RPC url of your choice.
    //   url: "https://alfajores-forno.celo-testnet.org",
    //   accounts: [
    //     [process.env.PRIVATE_KEY]
    //   ],
    // },
    // celo: {
    //   url: "https://forno.celo.org",
    //   accounts: [
    //     [process.env.PRIVATE_KEY]
    //   ],
    }
  },
  etherscan: {
    apiKey: {
        alfajores: "EWFHPD8U7PQ2WB5HS7J2Y17P2EYB8M8WU1",
        celo: "EWFHPD8U7PQ2WB5HS7J2Y17P2EYB8M8WU1"
    }
  }
};
