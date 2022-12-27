/** @type import('hardhat/config').HardhatUserConfig */
require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

const local_private_key = process.env.local_private_key;
const local_provider = process.env.local_provider;

module.exports = {
  solidity: "0.8.17",
  defaultNetwork: "hardhat",
  networks: {
    localnode: {
      url: local_provider,
      accounts: [local_private_key],
      chainId: 31337,
    },
  },
};
