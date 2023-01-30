pragma solidity 0.8.7;

contract Messanger{

    string public message;
    address owner;
    uint totalMsgCount;

    constructor() {
        owner = msg.sender;
    }

    function updateMessanger(string memory _message) public {
        require(owner == msg.sender,"Only the owner can Updated");
        message = _message;
        totalMsgCount;
    }
}