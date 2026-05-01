// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function transfer(address to, uint256 value) external returns (bool);
}

contract TokenPresale {
    address public owner;
    IERC20 public token;
    uint256 public rate; // How many tokens per 1 ETH

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    constructor(address _tokenAddress, uint256 _rate) {
        owner = msg.sender;
        token = IERC20(_tokenAddress);
        rate = _rate; // Example: 1000 = 1000 tokens per 1 POL
    }

    receive() external payable {
        buyTokens();
    }

    function buyTokens() public payable {
        require(msg.value > 0, "Send ETH to buy tokens");

        uint256 tokenAmount = msg.value * rate;
        require(token.transfer(msg.sender, tokenAmount), "Token transfer failed");
    }

    function withdrawPOL() external onlyOwner {
        payable(owner).transfer(address(this).balance);
    }

    function withdrawUnsoldTokens() external onlyOwner {
        uint256 balance = tokenBalance();
        require(token.transfer(owner, balance), "Withdraw failed");
    }

    function setRate(uint256 newRate) external onlyOwner {
        rate = newRate;
    }

    function tokenBalance() public view returns (uint256) {
        return tokenBalanceOf(address(this));
    }

   
}
