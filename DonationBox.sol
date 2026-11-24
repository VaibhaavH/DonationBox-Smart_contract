
 // SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract DonationBox {
    address payable public owner;

    uint public totalDonations;

    mapping(address => uint) public donations;

    constructor() {
        owner = payable(msg.sender);
    }

    function donate() public payable {
        require(msg.value > 0, "Donation must be greater than zero");

        donations[msg.sender] += msg.value;
        totalDonations += msg.value;
    }

    function withdraw() public {
        require(msg.sender == owner, "Only owner can withdraw");

        uint amount = address(this).balance;
        require(amount > 0, "No funds to withdraw");

        (bool success, ) = owner.call{value: amount}("");
        require(success, "Withdrawal failed");
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}
