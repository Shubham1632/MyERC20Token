const { ethers } = require("hardhat");
const fs = require("fs");

const key =
  "0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80";
const prov = "http://127.0.0.1:8545/";
const contractaddress = "0x5FbDB2315678afecb367f032d93F642f64180aa3";

const getcontract = async function () {
  const data = await fs.promises.readFile(
    "artifacts/contracts/mytoken.sol/shubhamscoin.json",
    "utf8"
  );
  const abi = JSON.parse(data)["abi"];
  const provider = ethers.getDefaultProvider(prov);
  const signer = new ethers.Wallet(key, provider);
  const contract = new ethers.Contract(contractaddress, abi, signer);
  return { contract };
};

// getcontract().catch((error) => {
//   console.log(error);
//   process.exitCode = 1;
// });

module.exports = getcontract();
