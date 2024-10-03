// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract SortArray {
    function sort(uint256[] memory arr) public pure returns (uint256[] memory) {
        uint256 length = arr.length;
        uint256 temp;
        for (uint256 i = 0; i < length - 1; i++) {
            for (uint256 j = 0; j < length - 1 - i; j++) {
                if (arr[j] > arr[j + 1]) {
                    temp = arr[j];
                    arr[j] = arr[j + 1];
                    arr[j + 1] = temp;
                }
            }
        }
        return arr;
    }
}
