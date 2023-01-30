pragma solidity 0.8.12;
import "@openzeppelin/contracts/utils/Strings.sol";

contract SmartWallet {

    mapping(address => uint) balanceReceived;
    mapping(address => string[]) transactionHistory;

    function addToWallet() public payable {
        require(msg.value >= 1000 wei,"Minimum Balance of 1000 wei required");
        balanceReceived[msg.sender] += msg.value;
        string memory converted = Strings.toString(msg.value);
        string memory strAddr = Strings.toHexString(msg.sender);
        string memory tempData = string.concat("Amount ",converted," was deposited by", strAddr);
        transactionHistory[msg.sender].push(tempData);
    }

    function getContactBalance() public view returns(uint) {
        return address(this).balance;
    }

    function withDraw(uint _amount) public {
        require(balanceReceived[msg.sender] >= _amount, "account balance insuffient");
        initiateWithDrawl(_amount);
    }

    function initiateWithDrawl(uint _amount) private {
        balanceReceived[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);
        string memory converted = Strings.toString(_amount);
        string memory strAddr = Strings.toHexString(msg.sender);
        string memory tempData = string.concat("Amount ",converted," was withdrawled by", strAddr);
        transactionHistory[msg.sender].push(tempData);
    }

    function getTransactionHistory(address _account) public view returns(string[] memory){
        return transactionHistory[_account];
    }

    function accessWallet() public view returns(uint){
        require(balanceReceived[msg.sender] > 0, "Wallet address not available");
        address _addr = msg.sender;
        return getWalletBalance(_addr);
    }

    function getWalletBalance(address _address) public view returns(uint){
        return balanceReceived[_address];
    }
}