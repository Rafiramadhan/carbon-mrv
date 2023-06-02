// This is a script for deploying your contracts. You can adapt it to deploy
// yours, or create new ones.

import { artifacts, ethers, network } from "hardhat";
import path from "path";
import fs from "fs";

async function main() {
  // This is just a convenience check
  if (network.name === "hardhat") {
    console.warn(
      "You are trying to deploy a contract to the Hardhat Network, which" +
        "gets automatically created and destroyed every time. Use the Hardhat" +
        " option '--network localhost'"
    );
  }

  // ethers is available in the global scope
  const [deployer] = await ethers.getSigners();
  console.log(
    "Deploying the contracts with the account:",
    await deployer.getAddress()
  );

  console.log("Account balance:", (await deployer.getBalance()).toString());

  const Token = await ethers.getContractFactory("Token");
  const token = await Token.deploy();
  await token.deployed();

  console.log("Token address:", token.address);

  const Monitoring = await ethers.getContractFactory("Monitoring");
  const monitoring = await Monitoring.deploy();
  await monitoring.deployed();

  const Reporting = await ethers.getContractFactory("Reporting");
  const reporting = await Reporting.deploy(
    [
      "0x976EA74026E726554dB657fA54763abd0C3a0aa9",
      "0x14dC79964da2C08b23698B3D3cc7Ca32193d9955",
      "0x23618e81E3f5cdF7f54C3d65f7FBc0aBf5B21E8f",
      "0xa0Ee7A142d267C1f36714E4a8F75612F20a79720",
      "0xBcd4042DE499D14e55001CcbB24a551F3b954096",
      "0x71bE63f3384f5fb98995898A86B02Fb2426c5788",
      "0xFABB0ac9d68B0B445fB7357272Ff202C5651694a",
      "0x1CBd3b2770909D4e10f157cABC84C7264073C9Ec",
    ],
    [
      "rafi.ramadhan27@gmail.com",
      "rafi.ramadhan27+9955@gmail.com",
      "rafi.ramadhan27+1E8f@gmail.com",
      "rafi.ramadhan27+9720@gmail.com",
      "rafi.ramadhan27+4096@gmail.com",
      "rafi.ramadhan27+5788@gmail.com",
      "rafi.ramadhan27+694a@gmail.com",
      "rafi.ramadhan27+C9Ec@gmail.com",
    ]
  );
  await reporting.deployed();

  console.log("Monitoring address:", monitoring.address);
  console.log("Reporting address:", reporting.address);

  // We also save the contract's artifacts and address in the frontend directory
  saveFrontendFiles(token, "Token");
  saveFrontendFiles(monitoring, "Monitoring");
  saveFrontendFiles(reporting, "Reporting");
}

// function saveFrontendFiles(contract: any, contractName: string) {
//   const currentContractName = contractName;
//   const fs = require("fs");
//   const contractsDir = path.join(
//     __dirname,
//     "..",
//     "frontend",
//     "src",
//     "contracts"
//   );

//   if (!fs.existsSync(contractsDir)) {
//     fs.mkdirSync(contractsDir);
//   }
//   console.log('contractName --> ', contractName)
//   fs.writeFileSync(
//     path.join(contractsDir, "contract-address.json"),
//     JSON.stringify({ [contractName]: contract.address }, undefined, 2)
//   );

//   const TokenArtifact = artifacts.readArtifactSync(contractName);

//   fs.writeFileSync(
//     path.join(contractsDir, `${contractName}.json`),
//     JSON.stringify(TokenArtifact, null, 2)
//   );
// }

function saveFrontendFiles(contract: any, contractName: string) {
  const contractsDir = path.join(
    __dirname,
    "..",
    "frontend",
    "src",
    "contracts"
  );
  if (!fs.existsSync(contractsDir)) {
    fs.mkdirSync(contractsDir);
  }
  const contractAddressFilePath = path.join(
    contractsDir,
    "contract-address.json"
  );
  let contractAddresses = {};
  if (fs.existsSync(contractAddressFilePath)) {
    const existingData = fs.readFileSync(contractAddressFilePath, "utf-8");
    contractAddresses = JSON.parse(existingData);
  }
  contractAddresses[contractName] = contract.address;
  fs.writeFileSync(
    contractAddressFilePath,
    JSON.stringify(contractAddresses, undefined, 2)
  );
  const TokenArtifact = artifacts.readArtifactSync(contractName);
  fs.writeFileSync(
    path.join(contractsDir, `${contractName}.json`),
    JSON.stringify(TokenArtifact, null, 2)
  );
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
