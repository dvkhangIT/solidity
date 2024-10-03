// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
import "./Nguoi.sol";

contract Sinhvien is Nguoi {
    string public TenLop;

    function Nhap(
        string memory _Hoten,
        string memory _Gioitinh,
        string memory _TenLop
    ) public {
        Nguoi.Nhap(_Hoten, _Gioitinh);
        TenLop = _TenLop;
    }

    function HienThiSV()
        public
        view
        returns (
            string memory,
            string memory,
            string memory
        )
    {
        (string memory hoten, string memory gioitinh) = Nguoi.Hien();
        return (hoten, gioitinh, TenLop);
    }
}
