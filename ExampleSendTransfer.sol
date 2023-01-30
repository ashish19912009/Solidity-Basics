pragma solidity 0.8.7;

contract Sender {

    receive() external payable {
    }

    function getContractBalance() public view returns(uint) {
        return address(this).balance;
    }

    function withdrawlTransfer(address payable _to) public {
        _to.transfer(10);
    }

    function withdrawlSend(address payable _to) public {
       bool status =  _to.send(10);
       require(status == true, "Sending the fund was unsuccessful");
    }
}

contract ReceiverNoAction {
    receive() external payable {}

    function balance() public view returns(uint) {
        return address(this).balance;
    }
}

contract ReceiverAction {
    uint public balanceReceived;
    receive() external payable {
        balanceReceived += msg.value;
    }
}