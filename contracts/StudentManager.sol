// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract StudentManager {
    uint256 public studentCount = 0;
    struct Student {
        uint256 id;
        string name;
        string gender;
        uint256 age;
        uint256 mathScore;
        uint256 physicsScore;
        uint256 chemistryScore;
        uint256 gpa;
        string academicPerformance;
    }

    mapping(uint256 => Student) public students;

    function addStudent(
        string memory _name,
        string memory _gender,
        uint256 _age,
        uint256 _mathScore,
        uint256 _physicsScore,
        uint256 _chemistryScore
    ) public {
        uint256 _gpa = calculateGPA(_mathScore, _physicsScore, _chemistryScore);
        string memory _academicPerformance = classifyPerformance(_gpa);
        studentCount++;
        students[studentCount] = Student(
            studentCount,
            _name,
            _gender,
            _age,
            _mathScore,
            _physicsScore,
            _chemistryScore,
            _gpa,
            _academicPerformance
        );
    }

    function updateStudent(
        uint256 _id,
        string memory _name,
        string memory _gender,
        uint256 _age,
        uint256 _mathScore,
        uint256 _physicsScore,
        uint256 _chemistryScore
    ) public {
        require(_id <= studentCount && _id > 0, "Student ID is invalid");
        uint256 _gpa = calculateGPA(_mathScore, _physicsScore, _chemistryScore);
        string memory _academicPerformance = classifyPerformance(_gpa);
        students[_id] = Student(
            _id,
            _name,
            _gender,
            _age,
            _mathScore,
            _physicsScore,
            _chemistryScore,
            _gpa,
            _academicPerformance
        );
    }

    function deleteStudent(uint256 _id) public {
        require(_id <= studentCount && _id > 0, "Student ID is invalid");
        delete students[_id];
    }

    function searchStudentByName(string memory _name)
        public
        view
        returns (Student[] memory)
    {
        uint256 foundCount = 0;
        for (uint256 i = 1; i <= studentCount; i++) {
            if (
                keccak256(abi.encodePacked(students[i].name)) ==
                keccak256(abi.encodePacked(_name))
            ) {
                foundCount++;
            }
        }

        Student[] memory foundStudents = new Student[](foundCount);
        uint256 index = 0;
        for (uint256 i = 1; i <= studentCount; i++) {
            if (
                keccak256(abi.encodePacked(students[i].name)) ==
                keccak256(abi.encodePacked(_name))
            ) {
                foundStudents[index] = students[i];
                index++;
            }
        }
        return foundStudents;
    }

    function sortStudentsByGPA() public view returns (Student[] memory) {
        Student[] memory sortedStudents = getAllStudents();
        for (uint256 i = 0; i < sortedStudents.length; i++) {
            for (uint256 j = i + 1; j < sortedStudents.length; j++) {
                if (sortedStudents[i].gpa < sortedStudents[j].gpa) {
                    Student memory temp = sortedStudents[i];
                    sortedStudents[i] = sortedStudents[j];
                    sortedStudents[j] = temp;
                }
            }
        }
        return sortedStudents;
    }

    function sortStudentsByName() public view returns (Student[] memory) {
        Student[] memory sortedStudents = getAllStudents();
        for (uint256 i = 0; i < sortedStudents.length; i++) {
            for (uint256 j = i + 1; j < sortedStudents.length; j++) {
                if (
                    keccak256(abi.encodePacked(sortedStudents[i].name)) >
                    keccak256(abi.encodePacked(sortedStudents[j].name))
                ) {
                    Student memory temp = sortedStudents[i];
                    sortedStudents[i] = sortedStudents[j];
                    sortedStudents[j] = temp;
                }
            }
        }
        return sortedStudents;
    }

    function sortStudentsByID() public view returns (Student[] memory) {
        Student[] memory sortedStudents = getAllStudents();
        for (uint256 i = 0; i < sortedStudents.length; i++) {
            for (uint256 j = i + 1; j < sortedStudents.length; j++) {
                if (sortedStudents[i].id > sortedStudents[j].id) {
                    Student memory temp = sortedStudents[i];
                    sortedStudents[i] = sortedStudents[j];
                    sortedStudents[j] = temp;
                }
            }
        }
        return sortedStudents;
    }

    function getAllStudents() public view returns (Student[] memory) {
        Student[] memory allStudents = new Student[](studentCount);
        for (uint256 i = 1; i <= studentCount; i++) {
            allStudents[i - 1] = students[i];
        }
        return allStudents;
    }

    function calculateGPA(
        uint256 _mathScore,
        uint256 _physicsScore,
        uint256 _chemistryScore
    ) internal pure returns (uint256) {
        return (_mathScore + _physicsScore + _chemistryScore) / 3;
    }

    function classifyPerformance(uint256 _gpa)
        internal
        pure
        returns (string memory)
    {
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
