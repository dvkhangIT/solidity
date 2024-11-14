// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LendingContract {
    struct Loan {
        uint256 amount;
        bool active;
    }

    mapping(address => uint256) public balances;
    mapping(address => Loan) public loans;

    // Sự kiện cho các giao dịch
    event Lend(address indexed lender, uint256 amount);
    event Borrow(address indexed borrower, uint256 amount);
    event Repay(address indexed borrower, uint256 amount);

    // Người dùng có thể gửi tiền để cho vay
    function lend() public payable {
        require(msg.value > 0, "Must send Ether to lend.");
        balances[msg.sender] += msg.value;
        emit Lend(msg.sender, msg.value);
    }

    // Người dùng có thể vay Ether nếu có đủ tiền trong hợp đồng
    function borrow(uint256 amount) public {
        require(amount > 0, "Must request an amount greater than zero.");
        require(
            balances[address(this)] >= amount,
            "Insufficient funds in contract."
        );
        require(
            !loans[msg.sender].active,
            "Existing loan must be repaid first."
        );

        loans[msg.sender] = Loan(amount, true);
        payable(msg.sender).transfer(amount);
        emit Borrow(msg.sender, amount);
    }

    // Người dùng trả lại số Ether đã vay
    function repay() public payable {
        Loan memory loan = loans[msg.sender];
        require(loan.active, "No active loan found.");
        require(msg.value == loan.amount, "Repayment amount must match loan.");

        loans[msg.sender].active = false;
        balances[address(this)] += msg.value;
        emit Repay(msg.sender, msg.value);
    }

    // Kiểm tra số dư của hợp đồng
    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
