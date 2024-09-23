// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;

contract Hello {
    uint256 public value;
    //private
    // internal 
    // public 
    // external 
    
    // function getValue() public view returns (uint256) {
    //     return value;
    // }

    function setValue(uint256 _value) external {
        value = _value;
    }
}
