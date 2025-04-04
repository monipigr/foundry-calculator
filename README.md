# ➕✖️➗ Foundry Calculator

## 📝 Overview

`Calculadora` is a Solidity smart contract that implements a basic calculator with historical results tracking for sums and access control (admin-only division). Developed using Foundry framework for testing experimentation.

## ✨ Features

- 🔢 **Basic Math Operations**:
  - `addition`, `substraction`, `multiplier`, `division`, `power`
- 🔐 **Admin Controls**:
  - Restricted `division` function to admin only
- 📊 **Historical Tracking**:
  - Stores last 10 addition results (reverts after limit)
- 🧪 **Test Coverage**:
  - Unit tests for all operations
  - Advanced fuzzing tests for division and power functions
  - Edge case testing (overflows, admin restrictions)

## 🧪 Testing with Foundry

| Test Function                          | Key Verification             |
| -------------------------------------- | ---------------------------- |
| `testAddition()`                       | Tests sum results            |
| `testSubstraction()`                   | Tests subtraction results    |
| `testMultiplier()`                     | Tests multiplication results |
| `testCanNotMultiply2LargeNumbers()`    | Prevents integer overflow    |
| `testAdminCanCallDivisionCorrectly()`  | Admin privileges work        |
| `testIfNotAdminCallsDivisionReverts()` | Non-admin blocks             |
| `testCanNotDivideBy0()`                | Division protection          |
| `testPower()`                          | Tests exponentiation         |
| `testResetResultado()`                 | Proper reset functionality   |
| `testAddToHistoricalSums()`            | Stores sum results correctly |

## 📜 License

This project is licensed under the MIT License.
