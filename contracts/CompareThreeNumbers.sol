// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract CompareThreeNumbers {
    event MaxMin(uint256 max, uint256 min);

    function compare(
        uint256 num1,
        uint256 num2,
        uint256 num3
    ) public pure returns (uint256 max, uint256 min) {
        max = num1;
        if (num2 > max) {
            max = num2;
        }
        if (num3 > max) {
            max = num3;
        }
        min = num1;
        if (num2 < min) {
            min = num2;
        }
        if (num3 < min) {
            min = num3;
        }
        // emit MaxMin(max, min);
    }
}
