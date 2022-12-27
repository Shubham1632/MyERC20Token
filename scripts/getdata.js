const { ethers } = require("hardhat");
const { contract } = require("./getcontract");

async function getdata() {
  const total = await contract.totalSupply();
  console.log(`The total supply is ${total}`);
}

getdata().catch((error) => {
  console.log(error);
  process.exitCode = 1;
});
