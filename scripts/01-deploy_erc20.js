const { ethers } = require("hardhat");

async function main() {
  const contractf = await ethers.getContractFactory("shubhamscoin");
  const contract = await contractf.deploy(
    "0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266",
    21000000
  );
  await contract.deployed();
  console.log(`the contract is deployed at ${contract.address}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
