// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import "../src/Calculadora.sol";
import "forge-std/Test.sol";

contract CalculadoraTest is Test {
    Calculadora calculadora; 
    uint256 public firstResultado = 100;
    address public admin = vm.addr(1);
    address public randomUser = vm.addr(2);

    function setUp() public {
        calculadora = new Calculadora(firstResultado, admin);
    }

    function testCheckFirstResultado() public view {
        uint256 firstResultado_ = calculadora.resultado(); 
        assert(firstResultado_ == firstResultado);
    }

    function testAddition() public {
        uint256 firstNumber_ = 5;
        uint256 secondNumber_ = 5;

        uint256 resultado_ = calculadora.addition(firstNumber_, secondNumber_);
        assert(resultado_ == firstNumber_ + secondNumber_);
    }
 
    function testSubstraction() public {
        uint256 firstNumber_ = 5;
        uint256 secondNumber_ = 5;

        uint256 resultado_ = calculadora.substraction(firstNumber_, secondNumber_);
        assert(resultado_ == firstNumber_ - secondNumber_);
    }

    function testMultiplier() public {
        uint256 firstNumber_ = 5;
        uint256 secondNumber_ = 5;

        uint256 resultado_ = calculadora.multiplier(firstNumber_, secondNumber_);
        assert(resultado_ == firstNumber_ * secondNumber_);
    }

    function testCanNotMultiply2LargeNumbers () public {
        uint256 firstNumber_ = 5;
        uint256 secondNumber_ = 115792089237316195423570985008687907853269984665640564039457584007913129639934;

        vm.expectRevert();
        calculadora.multiplier(firstNumber_, secondNumber_);
    }

    function testIfNotAdminCallsDivisionReverts() public {
        vm.startPrank(randomUser);

        uint256 firstNumber_ = 5;
        uint256 secondNumber_ = 2;
        vm.expectRevert();
        calculadora.division(firstNumber_, secondNumber_);

        vm.stopPrank();
    } 

    function testAdminCanCallDivisionCorrectly() public {
        vm.startPrank(admin);

        uint256 firstNumber_ = 5;
        uint256 secondNumber_ = 2;
        calculadora.division(firstNumber_, secondNumber_);

        vm.stopPrank();
    }

    function testDefaultCanNotCallDivisionCorrectly() public {
        uint256 firstNumber_ = 5;
        uint256 secondNumber_ = 2;
        console.log(msg.sender);
        vm.expectRevert();
        calculadora.division(firstNumber_, secondNumber_);
    }

    function testDefaultExecutesCorrectly() public {
        vm.prank(admin);
        uint256 firstNumber_ = 5;
        uint256 secondNumber_ = 2;
        uint256 resultado = calculadora.division(firstNumber_, secondNumber_);
        assert(resultado == firstNumber_ / secondNumber_);
        vm.stopPrank();
    }

    function testCanNotDivideBy0() public {
        vm.prank(admin);
        uint256 firstNumber_ = 5;
        uint256 secondNumber_ = 0;
        vm.expectRevert(bytes("Division by zero"));
        calculadora.division(firstNumber_, secondNumber_);
        vm.stopPrank();
    }

    // Fuzzing testing
    function testFuzzingDivision(uint256 firstNumber_, uint256 secondNumber_) public {
        vm.assume(secondNumber_ != 0);
        vm.prank(admin);
        calculadora.division(firstNumber_, secondNumber_);
        vm.stopPrank();
    }

    function testPower() public {
        uint256 base_ = 3;
        uint256 exponent_ = 2;
        uint256 resultado = calculadora.power(base_, exponent_);
        assert(resultado == base_ ** exponent_);
    }

    function testFuzzPower(uint256 base_, uint256 exponent_) public {
        vm.assume(exponent_ <= 10);
        vm.assume(base_ <= 1000);
        uint256 result = calculadora.power(base_, exponent_);
        assert(result == base_ ** exponent_);
    }

    function testResetResultado() public {
        calculadora.resetResultado();
        assert(calculadora.resultado() == 0);
    }

    function testAddToHistoricalSums() public {
        uint256 firstNumber_ = 5;
        uint256 secondNumber_ = 5;

        uint256 resultado_ = calculadora.addition(firstNumber_, secondNumber_);
        uint256 resultado2_ = calculadora.addition(3, 4);
        
        assert(calculadora.historicalResults(0) == resultado_);
        assert(calculadora.historicalResults(1) == resultado2_);
    }

}