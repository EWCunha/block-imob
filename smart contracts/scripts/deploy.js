const hre = require("hardhat");

async function main() {
  

  const Blockimobd = await ethers.getContractFactory("BlockImob")
  const blockimobd = await Blockimobd.deploy("SPU Hackathon","SPU")
  await blockimobd.deployed()
  console.log("--- BlockImob Deployed to ----",blockimobd.address)

  const Oracled = await ethers.getContractFactory("OracleGov")
  const oracled = await Oracled.deploy()
  await oracled.deployed()
  console.log("---OracleGov Deployed to ----",oracled.address)

  

  const Consultd = await ethers.getContractFactory("ConsultImob")
  const consultd = await Consultd.deploy(oracled.address)
  await consultd.deployed()
  console.log("--- ConsultImob Deployed to ----",consultd.address)

  

  const Paymentsd = await ethers.getContractFactory("PaymentsManagement")
  const paymentsd = await Paymentsd.deploy(blockimobd.address,consultd.address)
  await paymentsd.deployed()
  console.log("--- Payments Management Deployed to ----",paymentsd.address)



}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});