pragma solidity 0.8.7;

contract ExampleMapping {

    mapping(uint => bool) public myMapping;
    mapping(address => bool) public myAddressMapping;

    function setMapping(uint index) public {
        myMapping[index] = true;
    }

    function setMyAddressMapping() public {
        myAddressMapping[msg.sender] = true;
    }
}