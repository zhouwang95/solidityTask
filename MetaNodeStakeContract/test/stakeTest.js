const { ethers, deployments } = require("hardhat");
const { loadFixture } = require("@nomicfoundation/hardhat-network-helpers");
const { expect } = require("chai");
describe("test stake contract", function () {
  // 定义一个fixture，加载部署的合约
  async function deployStakeContractFixture() {
    // 加载标签为"MetaNodeStakeV1"的部署脚本（即你的部署逻辑）
    await deployments.fixture(["MetaNodeStakeV1"]); 

    // 通过部署标签获取合约信息（地址、ABI）
    const stakeDeployment = await deployments.get("MetaNodeStakeV1"); 
    // 注意：这里的"MetaNodeStakeV1"必须与部署脚本中save的名称一致

    // 打印部署信息，确认address和abi是否存在
    //console.log("stakeDeployment:", stakeDeployment); 
    //console.log("address是否存在:", stakeDeployment.address);
    //console.log("abi是否存在:", stakeDeployment.abi);

    // 用获取到的ABI和地址创建合约实例
    const stakeContract = await ethers.getContractAt(
      stakeDeployment.abi, // 从部署信息中获取ABI（非null）
      stakeDeployment.address // 从部署信息中获取地址（非null）
    );

    return { stakeContract };
  }

  it("Should be able to deploy", async function () {
    // 加载fixture并获取合约实例
    const { stakeContract } = await loadFixture(deployStakeContractFixture);

    // 验证合约地址有效（确保实例创建成功）
    //expect(await stakeContract.getAddress()).to.be.properAddress;
    const contractAddress = await stakeContract.getAddress();
    console.log("最终合约地址:", contractAddress);
    // 现在可以正常使用expect了
    expect(await stakeContract.getAddress()).to.be.properAddress;
  });
});