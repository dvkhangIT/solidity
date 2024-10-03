// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Nguoi {
    string public Hoten;
    string public Gioitinh;

    function Nhap(string memory _Hoten, string memory _Gioitinh) public {
        Hoten = _Hoten;
        Gioitinh = _Gioitinh;
    }

    function Hien() public view returns (string memory, string memory) {
        return (Hoten, Gioitinh);
    }
}
