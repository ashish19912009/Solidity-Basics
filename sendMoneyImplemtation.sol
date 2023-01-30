pragma solidity 0.8.7;

contract SendMoney{

    uint public contractBalance;

    function getContractBalance() public view returns(uint) {
        return address(this).balance;
    }

    function deposit() public payable {
        contractBalance += msg.value;
    }

    function withdrawAll() public {
        address payable to = payable(msg.sender);
        to.transfer(getContractBalance());
    }

    function withdrawToAddress(address payable to) public {
        to.transfer(getContractBalance());
    }

}