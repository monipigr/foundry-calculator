// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

contract Calculadora {

    uint256 public resultado;
    uint256[] public historicalResults; 
    address public admin;

    event Addition(uint256 firstNumber_, uint256 secondNumber_, uint256 resultado_);
    event Substraction(uint256 firstNumber_, uint256 secondNumber_, uint256 resultado_);
    event Multiplier(uint256 firstNumber_, uint256 secondNumber_, uint256 resultado_);
    event Division(uint256 firstNumber_, uint256 secondNumber_, uint256 resultado_);
    event Power(uint256 base_, uint256 exponent_, uint256 resultado_);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Not allowed");
        _;
    }

    constructor(uint256 firstResultado_, address admin_) {
        resultado = firstResultado_;
        admin = admin_;
    }

    function addition(uint256 firstNumber_, uint256 secondNumber_) external returns(uint256 resultado_) {
        resultado_ = firstNumber_ + secondNumber_;
        resultado = resultado_;
        addToHistoricalSums();

        emit Addition(firstNumber_, secondNumber_, resultado_);
    }

    function substraction(uint256 firstNumber_, uint256 secondNumber_) external returns(uint256 resultado_) {
        resultado_ = firstNumber_ - secondNumber_;
        resultado = resultado_;

        emit Substraction(firstNumber_, secondNumber_, resultado_);
    }

    // 3. Multiplier    
        function multiplier(uint256 firstNumber_, uint256 secondNumber_) external returns(uint256 resultado_) {
        resultado_ = firstNumber_ * secondNumber_;
        resultado = resultado_;

        emit Multiplier(firstNumber_, secondNumber_, resultado_);
    }

    function division(uint256 firstNumber_, uint256 secondNumber_) external onlyAdmin returns(uint256 resultado_) {
        require(secondNumber_ != 0, "Division by zero");
        resultado_ = firstNumber_ / secondNumber_;
        resultado = resultado_;

        emit Division(firstNumber_, secondNumber_, resultado_);
    }

    function power(uint256 base_, uint256 exponent_) external returns(uint256 resultado_) {
        require(exponent_ <= 10);
        require(base_ <= 1000);
        resultado_ = base_ ** exponent_;
        resultado = resultado_;

        emit Power(base_, exponent_, resultado_);
    }

    function resetResultado() public {
        resultado = 0;
    }

    // Guarda el historico de resultados de sumas. 
    function addToHistoricalSums() public {
        require(historicalResults.length <= 10, 'Not able to save');
        historicalResults.push(resultado);       
    }

}