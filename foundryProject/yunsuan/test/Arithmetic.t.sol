// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "forge-std/Test.sol";
import "../src/Arithmetic.sol";
import "../src/ArithmeticOptimized1.sol";
import "../src/ArithmeticOptimized2.sol";

/**
 * @title ArithmeticTest
 * @dev 测试算术运算合约及其优化版本
 */
contract ArithmeticTest is Test {
    Arithmetic public arithmetic;
    ArithmeticOptimized1 public optimized1;
    ArithmeticOptimized2 public optimized2;

    function setUp() public {
        arithmetic = new Arithmetic();
        optimized1 = new ArithmeticOptimized1();
        optimized2 = new ArithmeticOptimized2();
    }

    //测试原始版本
    function testOriginalAdd() public view {
        assertEq(arithmetic.add(6,9), 15);
        assertEq(arithmetic.add(123,456), 579);
        assertEq(arithmetic.add(100,200), 300);
    }
    function testOriginalSubtract() public view {
        assertEq(arithmetic.subtract(9,6), 3);
        assertEq(arithmetic.subtract(456,123), 333);
        assertEq(arithmetic.subtract(200,100), 100);
    }
    function testOriginalMultiply() public view {
        assertEq(arithmetic.multiply(6,9), 54);
        assertEq(arithmetic.multiply(100,200), 20000);
        assertEq(arithmetic.multiply(300,200), 60000);
    } 
    function testOriginalDivide() public view {
        assertEq(arithmetic.divide(60,30), 2);
        assertEq(arithmetic.divide(600,200), 3);
        assertEq(arithmetic.divide(300,2), 150);
    }



    // 测试第一个优化版本
    function testOptimized1Add() public view {
        assertEq(optimized1.add(6,9), 15);
        assertEq(optimized1.add(123,456), 579);
        assertEq(optimized1.add(100,200), 300);
    }
    function testOptimized1Subtract() public view {
        assertEq(optimized1.subtract(9,6), 3);
        assertEq(optimized1.subtract(456,123), 333);
        assertEq(optimized1.subtract(200,100), 100);
    }
    function testOptimized1Multiply() public view {
        assertEq(optimized1.multiply(6,9), 54);
        assertEq(optimized1.multiply(100,200), 20000);
        assertEq(optimized1.multiply(300,200), 60000);
    } 
    function testOptimized1Divide() public view {
        assertEq(optimized1.divide(60,30), 2);
        assertEq(optimized1.divide(600,200), 3);
        assertEq(optimized1.divide(300,2), 150);
    }

    // 测试第二个优化版本
    function testOptimized2Add() public view {
        assertEq(optimized2.add(6,9), 15);
        assertEq(optimized2.add(123,456), 579);
        assertEq(optimized2.add(100,200), 300);
    }
    function testOptimized2Subtract() public view {
        assertEq(optimized2.subtract(9,6), 3);
        assertEq(optimized2.subtract(456,123), 333);
        assertEq(optimized2.subtract(200,100), 100);
    }
    function testOptimized2Multiply() public view {
        assertEq(optimized2.multiply(6,9), 54);
        assertEq(optimized2.multiply(100,200), 20000);
        assertEq(optimized2.multiply(300,200), 60000);
    } 
    function testOptimized2Divide() public view {
        assertEq(optimized2.divide(60,30), 2);
        assertEq(optimized2.divide(600,200), 3);
        assertEq(optimized2.divide(300,2), 150);
    }


    // 专门用于Gas消耗测试的函数
    function testGasOriginalAdd() public view {
        arithmetic.add(6,9);
    }
    function testGasOriginalSubtract() public view {
        arithmetic.subtract(9,6);
    }
    function testGasOriginalMultiply() public view {
        arithmetic.multiply(6,9);
    }
    function testGasOriginalDivide() public view {
        arithmetic.divide(60,30);
    }


    function testGasOptimized1Add() public view {
        optimized1.add(6,9);
    }
    function testGasOptimized1Subtract() public view {
        optimized1.subtract(9,6);
    }
    function testGasOptimized1Multiply() public view {
        optimized1.multiply(6,9);
    }
    function testGasOptimized1Divide() public view {
        optimized1.divide(60,30);
    }



    function testGasOptimized2Add() public view {
        optimized2.add(6,9);
    }
    function testGasOptimized2Subtract() public view {
        optimized2.subtract(9,6);
    }
    function testGasOptimized2Multiply() public view {
        optimized2.multiply(6,9);
    }
    function testGasOptimized2Divide() public view {
        optimized2.divide(60,30);
    }
}