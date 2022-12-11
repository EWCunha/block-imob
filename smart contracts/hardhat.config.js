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
      // forking: {
      // //   url: "https://rpc.ankr.com/celo",
      // //   //url: "https://eth-mainnet.g.alchemy.com/v2/VmVQQLge3XZR43ratreK9R9OQdwr1SkJ",
      // //   // url: "https://polygon-mainnet.g.alchemy.com/v2/sgGpIHWGIXwJcVatpKKW4j0k3jY9mg1O",
      // },
    },
    alfajores: {
      // can be replaced with the RPC url of your choice.
      url: "https://alfajores-forno.celo-testnet.org",
      accounts: [
        [process.env.PRIVATE_KEY]
      ],
    },
    celo: {
      url: "https://forno.celo.org",
      accounts: [
        [process.env.PRIVATE_KEY]
      ],
    }
    // testnet: {
    //   url: process.env.TESTNET_RPC,
    //   accounts: [process.env.PRIVATE_KEY]
    // }
  },
  etherscan: {
    apiKey: {
        alfajores: process.env.CELOSCAN_APIKEY,
        celo: process.env.CELOSCAN_APIKEY
    }
  }
};
