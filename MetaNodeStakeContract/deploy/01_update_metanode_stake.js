const { deployments, upgrades, ethers } = require('hardhat');

const fs = require('fs');
const path = require('path');

module.exports = async ({getNamedAccounts, deployments}) => {
    const {save} = deployments;
    const {deployer} = await getNamedAccounts();
    console.log("部署用户地址：", deployer);

    // 读取cache中存储的旧版本的代理合约地址
    const cachePath = path.resolve(__dirname, "./.cache/metaNodeStake.json");
    const cache = JSON.parse(fs.readFileSync(cachePath, "utf-8"));
    const metaNodeStakeProxyAddress = cache.metaNodeStakeProxyAddress;
    const metaNodeStakeImplAddress = cache.metaNodeStaktImplAddress;
    console.log("使用的代理地址（升级前后不变）：", metaNodeStakeProxyAddress);
    //部署质押合约
      const stakeArtifactPath = path.resolve(
            __dirname, 
            '../artifacts/contracts/MetaNodeStake.sol/MetaNodeStake.json'
        );
    // 读取 artifact
    const stakeArtifact = JSON.parse(fs.readFileSync(stakeArtifactPath, 'utf8'));
    console.log("手动读取的 ABI 是否有效:", Array.isArray(stakeArtifact.abi));

    // 升级合约
    const metaNodeStakeFac = await ethers.getContractFactory("MetaNodeStakeV2")
    const metaNodeStake = await upgrades.upgradeProxy(metaNodeStakeProxyAddress, metaNodeStakeFac)
    await metaNodeStake.waitForDeployment()

    const proxyAddressAfterUpgrade  = await metaNodeStake.getAddress()
    console.log("升级后代理地址（应与原地址相同）：", proxyAddressAfterUpgrade)

    // 获取实际的合约地址
    const metaNodeStakeImplAddressV2 = await upgrades.erc1967.getImplementationAddress(proxyAddressAfterUpgrade )
    console.log("新实现地址（升级后）：", metaNodeStakeImplAddressV2)


    //保存合约地址
    const storePath = path.resolve(__dirname, "./.cache/metaNodeStake.json");
    fs.writeFileSync(storePath, JSON.stringify({
        metaNodeStakeProxyAddress:proxyAddressAfterUpgrade,
        metaNodeStakeImplAddress:metaNodeStakeImplAddressV2,
        abi: metaNodeStakeFac.abi
    }));

    await save("MetaNodeStakeV1", {
        address: proxyAddressAfterUpgrade,
        implAddress: metaNodeStakeImplAddressV2,
        abi: metaNodeStakeFac.abi
    });

}

module.exports.tags = ["MetaNodeStakeV2"];