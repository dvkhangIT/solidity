// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract HouseManager {
    struct House {
        uint256 id;
        string house_address;
        address owner;
    }
    House[] public houses;
    mapping(uint256 => address) public owners;
    uint256 public houseCount = 0;
    event HouseAdded(uint256 id, string house_address, address owner);
    event HouseDeleted(uint256 id);
    event HouseUpdated(uint256 id, string new_address);

    function addHouse(string memory _houseAddress) public {
        House memory newHouse = House({
            id: houseCount,
            house_address: _houseAddress,
            owner: msg.sender
        });
        houses.push(newHouse);
        owners[houseCount] = msg.sender;
        houseCount++;
        emit HouseAdded(newHouse.id, newHouse.house_address, newHouse.owner);
    }

    function deleteHouse(uint256 _id) public {
        require(owners[_id] == msg.sender, "You are not owner");
        for (uint256 i = 0; i < houses.length; i++) {
            if (houses[i].id == _id) {
                houses[i] = houses[houses.length - 1];
                houses.pop();
                delete owners[_id];
                emit HouseDeleted(_id);
                return;
            }
        }
    }

    function updateHouse(uint256 _id, string memory _newAddress) public {
        require(owners[_id] == msg.sender, "You are not owner");
        for (uint256 i = 0; i < houses.length; i++) {
            if (houses[i].id == _id) {
                houses[i].house_address = _newAddress;
                emit HouseUpdated(_id, _newAddress);
                return;
            }
        }
    }

    function getAllHouses() public view returns (House[] memory) {
        return houses;
    }
}
