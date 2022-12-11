// // We require the Hardhat Runtime Environment explicitly here. This is optional
// // but useful for running the script in a standalone fashion through `node <script>`.
// //
// // You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// // will compile your contracts, add the Hardhat Runtime Environment's members to the
// // global scope, and execute the script.
// const hre = require("hardhat");

// async function main() {
//   const currentTimestampInSeconds = Math.round(Date.now() / 1000);
//   const ONE_YEAR_IN_SECS = 365 * 24 * 60 * 60;
//   const unlockTime = currentTimestampInSeconds + ONE_YEAR_IN_SECS;

//   const lockedAmount = hre.ethers.utils.parseEther("1");

//   const Lock = await hre.ethers.getContractFactory("Lock");
//   const lock = await Lock.deploy(unlockTime, { value: lockedAmount });

//   await lock.deployed();

//   console.log(
//     `Lock with 1 ETH and unlock timestamp ${unlockTime} deployed to ${lock.address}`
//   );
// }

// // We recommend this pattern to be able to use async/await everywhere
// // and properly handle errors.
// main().catch((error) => {
//   console.error(error);
//   process.exitCode = 1;
// });
const hre = require("hardhat");

async function main() {
  

  const Blockimob = await ethers.getContractFactory("BlockImob")
  const blockimob = await Blockimob.connect(accounts[0]).deploy("SPU Hackathon","SPU")
  await blockimob.deployed()
  console.log("--- BlockImob Deployed to ----",blockimob.address)

  const Oracle = await ethers.getContractFactory("OracleGov")
  const oracle = await Oracle.deploy()
  await oracle.deployed()
  console.log("---OracleGov Deployed to ----",oracle.address)

  // await blockimob.connect(accounts[0]).changeAllow(oracle.address,true);

  const Consult = await ethers.getContractFactory("ConsultImob")
  const consult = await Consult.deploy(oracle.address)
  await consult.deployed()
  console.log("--- ConsultImob Deployed to ----",consult.address)

  // await blockimob.connect(accounts[0]).changeAllow(consult.address,true);

  const Payments = await ethers.getContractFactory("PaymentsManagement")
  const payments = await Payments.deploy(blockimob.address,consult.address)
  await payments.deployed()
  console.log("--- Payments Management Deployed to ----",payments.address)

  // await blockimob.connect(accounts[0]).changeAllow(payments.address,true);

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});