// SPDX-license_Identifier: MIT

pragma solidity ^0.6.6;

import "./Lesson1_Storage.sol";

contract StorageFactory is Storage{
    Storage[] public sta;

    function CreateSC() public {
        Storage bag = new Storage();
        sta.push(bag);
    }
    function sfstr(uint256 index, int num) public{
        Storage(address(sta[index])).str(num);
    }
    function sfget(uint256 index) public view returns (int)
    {
        return Storage(address(sta[index])).retrieve();
    }
}