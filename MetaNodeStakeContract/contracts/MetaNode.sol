// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MetaNodeToken is ERC20{
    constructor(uint256 _totalSupply) ERC20("MyMetaNodeToken", "MetaNode"){
        // 初始供应量可以在这里定义，或者留空以便之后通过 mint 函数铸造
         _mint(msg.sender, _totalSupply);
    }
}