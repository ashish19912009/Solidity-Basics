pragma solidity 0.8.15;

contract MappingStructExample {

    struct Transaction {
        uint amount;
        uint timestamp;
    }

    struct Balance {
        uint totalBalance;
        uint numDeposits;
        mapping(uint => Transaction) depositTrans;
        uint numWithdrawls;
        mapping(uint => Transaction) withdrawlTrans;
    }

    mapping(address => Balance) public balances;

    function depositMoney() public payable {
        balances[msg.sender].totalBalance += msg.value;
        Transaction memory trans = Transaction(msg.value,block.timestamp);
        balances[msg.sender].depositTrans[balances[msg.sender].numDeposits] = trans;
        balances[msg.sender].numDeposits++;
    }

    function withdrawlMoney(address payable _to,uint _amount) public {
        require(address(this).balance >= _amount,"insufficient fund");
        balances[msg.sender].totalBalance -= _amount;
        Transaction memory trans = Transaction(_amount, block.timestamp);
        balances[msg.sender].withdrawlTrans[balances[msg.sender].numWithdrawls] = trans;
        balances[msg.sender].numWithdrawls++;
        _to.transfer(_amount);
    }

    function getDepostiHistory(address _from,uint _trans) view public returns(Transaction memory) {
        return balances[_from].depositTrans[_trans];
    }
}