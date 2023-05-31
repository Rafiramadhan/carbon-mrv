import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

// The next line is part of the sample project, you don't need it in your
// project. It imports a Hardhat task definition, that can be used for
// testing the frontend.
require("./tasks/faucet");

// const INFURA_API_KEY = "KEY";

// const SEPOLIA_PRIVATE_KEY = "YOUR SEPOLIA PRIVATE KEY";

const config: HardhatUserConfig = {
  solidity: "0.8.18",
//   networks: {
//     sepolia: {
//       url: `https://sepolia.infuria.io/v3/${INFURA_API_KEY}`,
//       accounts: [SEPOLIA_PRIVATE_KEYN]
//     }
//   }
};

export default config;
