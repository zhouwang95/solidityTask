const { deployments, upgrades, ethers } = require('hardhat');

const fs = require('fs');
const path = require('path');

module.exports = async ({getNamedAccounts, deployments}) => {
    const {save} = deployments;
    const {deployer} = await getNamedAccounts();
    console.log("部署用户地址：", deployer);

    //部署ERC20合约
    const metaNodeFactory = await ethers.getContractFactory("MetaNodeToken");
    const metaNode = await metaNodeFactory.deploy(100000000);
    await metaNode.waitForDeployment();
    const metaNodeAddress = await metaNode.getAddress();
    console.log("MetaNode deploy address:", metaNodeAddress);

    //部署质押合约
      const stakeArtifactPath = path.resolve(
            __dirname, 
            '../artifacts/contracts/MetaNodeStake.sol/MetaNodeStake.json'
        );
    // 读取 artifact
    const stakeArtifact = JSON.parse(fs.readFileSync(stakeArtifactPath, 'utf8'));
    console.log("手动读取的 ABI 是否有效:", Array.isArray(stakeArtifact.abi));
    const stakeFactory = await ethers.getContractFactory(
        stakeArtifact.abi, 
        stakeArtifact.bytecode // 同时传入字节码
    );

    const stakeFactory1 = await ethers.getContractFactory("MetaNodeStake");

    //const stakeFactory = await ethers.getContractFactory("MetaNodeStake");
    //通过UUPS部署
    const metaNodeStakeProxy = await upgrades.deployProxy(
        stakeFactory,
        [metaNodeAddress,10000,10020,100000],//初始化函数的参数
        {initializer: 'initialize'}
    );
    await metaNodeStakeProxy.waitForDeployment();
    const metaNodeStakeProxyAddress = await metaNodeStakeProxy.getAddress();
    //代理合约地址
    console.log("MetaNodeStake proxy address:", metaNodeStakeProxyAddress);

    //逻辑合约地址
    const metaNodeStaktImplAddress = await upgrades.erc1967.getImplementationAddress(metaNodeStakeProxyAddress);
    console.log("MetaNodeStake address:", metaNodeStaktImplAddress);

    console.log("stakeFactory1 abi:", stakeFactory1.abi);


    //保存合约地址
    const storePath = path.resolve(__dirname, "./.cache/metaNodeStake.json");
    fs.writeFileSync(storePath, JSON.stringify({
        metaNodeStakeProxyAddress,
        metaNodeStaktImplAddress,
        abi: stakeArtifact.abi
    }));

    await save("MetaNodeStakeV1", {
        address: metaNodeStakeProxyAddress,
        implAddress: metaNodeStaktImplAddress,
        abi: stakeArtifact.abi
    });

}

module.exports.tags = ["MetaNodeStakeV1"];