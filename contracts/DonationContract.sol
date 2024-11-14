// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract DonationContract {
    address public owner;

    // Mappings để lưu trữ tổng số tiền mà mỗi địa chỉ đã tặng
    mapping(address => uint256) public donations;

    // Mảng lưu trữ danh sách người tặng
    address[] public donors;

    constructor() {
        // Thiết lập chủ sở hữu hợp đồng là người triển khai
        owner = msg.sender;
    }

    // Hàm cho phép người dùng tặng tiền vào hợp đồng
    function donate() public payable {
        require(msg.value > 0, "Donation must be greater than zero");

        // Kiểm tra nếu người tặng chưa có trong danh sách thì thêm họ vào
        if (donations[msg.sender] == 0) {
            donors.push(msg.sender);
        }

        // Cộng dồn số tiền tặng cho người gửi
        donations[msg.sender] += msg.value;
    }

    // Hàm cho phép chủ sở hữu rút toàn bộ số tiền
    function withdrawAll() public {
        require(msg.sender == owner, "Only the owner can withdraw");
        payable(owner).transfer(address(this).balance);
    }

    // Hàm cho phép chủ sở hữu rút một phần số tiền
    function withdraw(uint256 amount) public {
        require(msg.sender == owner, "Only the owner can withdraw");
        require(
            amount <= address(this).balance,
            "Insufficient balance in contract"
        );
        payable(owner).transfer(amount);
    }

    // Hàm trả về danh sách tất cả người tặng và số tiền họ đã tặng
    function getDonors()
        public
        view
        returns (address[] memory, uint256[] memory)
    {
        uint256[] memory amounts = new uint256[](donors.length);

        for (uint256 i = 0; i < donors.length; i++) {
            amounts[i] = donations[donors[i]];
        }

        return (donors, amounts);
    }

    // Hàm trả về tổng số dư của hợp đồng
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
