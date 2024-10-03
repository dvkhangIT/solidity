// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract CheckEvenOdd {
    function isEven(uint256 _num) public pure returns (string memory) {
        if (_num % 2 == 0) {
            return "Event";
        } else {
            return "Odd";
        }
    }
}
