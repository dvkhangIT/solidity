// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract StudentManager {
    uint public studentCount = 0; // Biến đếm tự động tăng mã sinh viên
    struct Student {
        uint id;
        string name;
        string gender;
        uint age;
        uint mathScore;
        uint physicsScore;
        uint chemistryScore;
        uint gpa;
        string academicPerformance;
    }

    mapping(uint => Student) public students;

    // Thêm sinh viên mới
    function addStudent(string memory _name, string memory _gender, uint _age, uint _mathScore, uint _physicsScore, uint _chemistryScore) public {
        uint _gpa = calculateGPA(_mathScore, _physicsScore, _chemistryScore);
        string memory _academicPerformance = classifyPerformance(_gpa);
        studentCount++;
        students[studentCount] = Student(studentCount, _name, _gender, _age, _mathScore, _physicsScore, _chemistryScore, _gpa, _academicPerformance);
    }

    // Cập nhật thông tin sinh viên
    function updateStudent(uint _id, string memory _name, string memory _gender, uint _age, uint _mathScore, uint _physicsScore, uint _chemistryScore) public {
        require(_id <= studentCount && _id > 0, "Student ID is invalid");
        uint _gpa = calculateGPA(_mathScore, _physicsScore, _chemistryScore);
        string memory _academicPerformance = classifyPerformance(_gpa);
        students[_id] = Student(_id, _name, _gender, _age, _mathScore, _physicsScore, _chemistryScore, _gpa, _academicPerformance);
    }

    // Xóa sinh viên theo ID
    function deleteStudent(uint _id) public {
        require(_id <= studentCount && _id > 0, "Student ID is invalid");
        delete students[_id];
    }

    // Tìm kiếm sinh viên theo tên
    function searchStudentByName(string memory _name) public view returns (Student[] memory) {
        uint foundCount = 0;
        for (uint i = 1; i <= studentCount; i++) {
            if (keccak256(abi.encodePacked(students[i].name)) == keccak256(abi.encodePacked(_name))) {
                foundCount++;
            }
        }
        
        Student[] memory foundStudents = new Student[](foundCount);
        uint index = 0;
        for (uint i = 1; i <= studentCount; i++) {
            if (keccak256(abi.encodePacked(students[i].name)) == keccak256(abi.encodePacked(_name))) {
                foundStudents[index] = students[i];
                index++;
            }
        }
        return foundStudents;
    }

    // Sắp xếp sinh viên theo GPA
    function sortStudentsByGPA() public view returns (Student[] memory) {
        Student[] memory sortedStudents = getAllStudents();
        for (uint i = 0; i < sortedStudents.length; i++) {
            for (uint j = i + 1; j < sortedStudents.length; j++) {
                if (sortedStudents[i].gpa < sortedStudents[j].gpa) {
                    Student memory temp = sortedStudents[i];
                    sortedStudents[i] = sortedStudents[j];
                    sortedStudents[j] = temp;
                }
            }
        }
        return sortedStudents;
    }

    // Sắp xếp sinh viên theo tên
    function sortStudentsByName() public view returns (Student[] memory) {
        Student[] memory sortedStudents = getAllStudents();
        for (uint i = 0; i < sortedStudents.length; i++) {
            for (uint j = i + 1; j < sortedStudents.length; j++) {
                if (keccak256(abi.encodePacked(sortedStudents[i].name)) > keccak256(abi.encodePacked(sortedStudents[j].name))) {
                    Student memory temp = sortedStudents[i];
                    sortedStudents[i] = sortedStudents[j];
                    sortedStudents[j] = temp;
                }
            }
        }
        return sortedStudents;
    }

    // Sắp xếp sinh viên theo ID
    function sortStudentsByID() public view returns (Student[] memory) {
        Student[] memory sortedStudents = getAllStudents();
        for (uint i = 0; i < sortedStudents.length; i++) {
            for (uint j = i + 1; j < sortedStudents.length; j++) {
                if (sortedStudents[i].id > sortedStudents[j].id) {
                    Student memory temp = sortedStudents[i];
                    sortedStudents[i] = sortedStudents[j];
                    sortedStudents[j] = temp;
                }
            }
        }
        return sortedStudents;
    }

    // Hiển thị tất cả sinh viên
    function getAllStudents() public view returns (Student[] memory) {
        Student[] memory allStudents = new Student[](studentCount);
        for (uint i = 1; i <= studentCount; i++) {
            allStudents[i - 1] = students[i];
        }
        return allStudents;
    }

    // Tính điểm trung bình
    function calculateGPA(uint _mathScore, uint _physicsScore, uint _chemistryScore) internal pure returns (uint) {
        return (_mathScore + _physicsScore + _chemistryScore) / 3;
    }

    // Xếp loại học lực
    function classifyPerformance(uint _gpa) internal pure returns (string memory) {
        if (_gpa >= 8) {
            return "Gioi";
        } else if (_gpa >= 6) {
            return "Kha";
        } else if (_gpa >= 5) {
            return "Trung Binh";
        } else {
            return "Yeu";
        }
    }
}
