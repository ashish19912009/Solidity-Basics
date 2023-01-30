// SPDX-license-Interifier: MIT

pragma solidity ^0.8.7;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract VirdhaToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("VirdhaToken", "RENA"){
        _mint(msg.sender, initialSupply);
    }
}
