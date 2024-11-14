// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract PersonalWallet {
    // Lưu trữ số dư của từng người dùng
    mapping(address => uint256) public balances;

    // Hàm cho phép người dùng gửi tiền vào hợp đồng
    function deposit() public payable {   
        require(msg.value > 0, "Deposit must be greater than zero");

        // Cộng dồn số tiền vào số dư của người gửi
        balances[msg.sender] += msg.value;
    }

    // Hàm cho phép người dùng rút toàn bộ số tiền của mình
    function withdrawAll() public {
        uint256 amount = balances[msg.sender];
        require(amount > 0, "Insufficient balance");

        // Cập nhật số dư của người dùng về 0 trước khi chuyển tiền
        balances[msg.sender] = 0;

        // Chuyển toàn bộ số tiền của người dùng
        payable(msg.sender).transfer(amount);
    }

    // Hàm cho phép người dùng rút một phần số tiền của mình
    function withdraw(uint256 amount) public {
        require(amount > 0, "Withdraw amount must be greater than zero");
        require(balances[msg.sender] >= amount, "Insufficient balance");

        // Trừ số tiền rút từ số dư của người dùng
        balances[msg.sender] -= amount;

        // Chuyển số tiền yêu cầu
        payable(msg.sender).transfer(amount);
    }

    // Hàm trả về số dư của người dùng
    function getBalance() public view returns (uint256) {
        return balances[msg.sender];
    }
}
