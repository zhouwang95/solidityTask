// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

/**
 * @title ArithmeticOptimized1
 * @dev 第一次优化：使用unchecked块避免溢出检查
 */
contract ArithmeticOptimized1 {
    //加法运算
    function add(uint256 a, uint256 b) public pure returns (uint256) {
        unchecked {
            return a + b;
        }
    }

    //减法运算
    function subtract(uint256 a, uint256 b) public pure returns (uint256) {
        require(b <= a,"Subtraction underflow");
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
        require(b > 0,"Division by zero");
        unchecked {
            return a / b;
        }
    }
}