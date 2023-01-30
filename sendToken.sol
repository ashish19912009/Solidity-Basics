pragma solidity 0.8.7;

contract EventExample {

    mapping(address => uint) public tokenBalance;
    address payable public test;
    event TokenSent(address _from, address _to, uint _amount);

    constructor() {
        tokenBalance[msg.sender] = 100;
    }

    function sendToken(address _to, uint _amount) payable public returns(bool) {
        require(tokenBalance[msg.sender] >= _amount, "Not enough tokens");
        tokenBalance[msg.sender] -= _amount;
        tokenBalance[_to] += _amount;

        test = address payable(0x0);

        emit TokenSent(msg.sender, _to, _amount);

        return true;
    }
}