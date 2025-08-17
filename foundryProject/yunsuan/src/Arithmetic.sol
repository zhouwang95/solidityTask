// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract Arithmetic {
    //加法运算
    function add(uint256 a, uint256 b) public pure returns (uint256) {
        return a + b;
    }

    //减法运算
    function subtract(uint256 a, uint256 b) public pure returns (uint256) {
        require(b <= a,"Subtraction underflow");
        return a - b;
    }

    //乘法运算
    function multiply(uint256 a, uint256 b) public pure returns (uint256) {
        return a * b;
    }

    //除法运算
    function divide(uint256 a, uint256 b) public pure returns (uint256) {
        require(b > 0,"Division by zero");
        return a / b;
    }
}