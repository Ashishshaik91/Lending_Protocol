// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LendingProtocol {
    mapping(address => uint) public balances;
    mapping(address => uint) public collateral;
    uint public totalLent;

    // Constructor that is payable to accept Ether during deployment
    constructor() payable {
        totalLent += msg.value;  // Optionally initialize the contract with sent Ether
    }
    // Function to get the contract's Ether balance
    function getContractBalance() public view returns (uint) {
    return address(this).balance;
}

    // Deposit function to add funds to the contract
    function deposit() public payable {
        balances[msg.sender] += msg.value;
        totalLent += msg.value;
    }

    // Borrow function with collateral check
    function borrow(uint amount) public {
        require(amount <= totalLent, "Insufficient funds");
        require(collateral[msg.sender] > 0, "No collateral provided");

        // Ensure borrower has provided collateral greater than or equal to the amount borrowed
        require(collateral[msg.sender] >= amount, "Insufficient collateral");

        // Transfer funds to borrower
        balances[msg.sender] += amount;
        totalLent -= amount;

        // Transfer the borrowed amount (safe call)
        (bool sent, ) = msg.sender.call{value: amount}("");
        require(sent, "Transfer failed");

        // Update the balance after successful transfer
        balances[msg.sender] -= amount;
    }

    // Repay function to return borrowed funds
    function repay() public payable {
        require(balances[msg.sender] > 0, "No loan to repay");

        balances[msg.sender] -= msg.value;
        totalLent += msg.value;
    }

    // Function to provide collateral
    function provideCollateral() public payable {
        require(msg.value > 0, "Collateral must be greater than 0");
        collateral[msg.sender] += msg.value;
    }

    // Function to withdraw collateral
    function withdrawCollateral(uint amount) public {
        require(collateral[msg.sender] >= amount, "Insufficient collateral");
        collateral[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }
}
