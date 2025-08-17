// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

/**
 * @title ArithmeticOptimized2
 * @dev 第二次优化：使用revert代替require，进一步优化代码结构
 */
contract ArithmeticOptimized2 {
    //合并错误信息为常量，减少部署成本
    error SubtractionUnderflow();
    error DivisionByZero();
    //加法运算
    function add(uint256 a, uint256 b) public pure returns (uint256) {
        unchecked {
            return a + b;
        }
    }

    //减法运算
    function subtract(uint256 a, uint256 b) public pure returns (uint256) {
        //require(b <= a,"Subtraction underflow");
        if(b > a){ revert SubtractionUnderflow(); }
        unchecked {
            return a - b;
        }
    }

    //乘法运算
    function multiply(uint256 a, uint256 b) public pure returns (uint256) {
        unchecked {
           return a * b;
        }
    }

    //除法运算
    function divide(uint256 a, uint256 b) public pure returns (uint256) {
        //require(b > 0,"Division by zero");
        if(b == 0){ revert DivisionByZero(); }
        unchecked {
            return a / b;
        }
    }
}