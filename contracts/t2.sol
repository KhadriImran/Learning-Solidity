/**
 *Submitted for verification at amoy.polygonscan.com on 2025-04-16
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract  token2_Erc20{
    string public name = "Polyhech";
    string public symbol = "PLH";
    uint8 public decimals = 18; // Same as USDT (6 decimals)
    uint256 public totalSupply;

    mapping(address => uint256) private balances;
    mapping(address => mapping(address => uint256)) private allowances;

    address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can execute this");
        _;
    }

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor(uint256 initialSupply) {
        owner = msg.sender;
        totalSupply = initialSupply * 10**decimals;
        balances[msg.sender] = totalSupply;
        emit Transfer(address(0), msg.sender, totalSupply);
    }

    function balanceOf(address account) public view returns (uint256) {
        return balances[account];
    }

    function transfer(address to, uint256 value) public returns (bool) {
        require(balances[msg.sender] >= value, "Insufficient balance");
        require(to != address(0), "Invalid address");

        balances[msg.sender] -= value;
        balances[to] += value;

        emit Transfer(msg.sender, to, value);
        return true;
    }

    function approve(address spender, uint256 value) public returns (bool) {
        require(spender != address(0), "Invalid address");

        allowances[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    function allowance(address owner, address spender) public view returns (uint256) {
        return allowances[owner][spender];
    }

    function transferFrom(address from, address to, uint256 value) public returns (bool) {
        require(balances[from] >= value, "Insufficient balance");
        require(allowances[from][msg.sender] >= value, "Allowance exceeded");
        require(to != address(0), "Invalid address");

        balances[from] -= value;
        allowances[from][msg.sender] -= value;
        balances[to] += value;

        emit Transfer(from, to, value);
        return true;
    }

    function mint(address account, uint256 value) public onlyOwner returns (bool) {
        require(account != address(0), "Invalid address");

        uint256 amount = value * 10**decimals;
        totalSupply += amount;
        balances[account] += amount;

        emit Transfer(address(0), account, amount);
        return true;
    }

    function burn(uint256 value) public returns (bool) {
        require(balances[msg.sender] >= value, "Insufficient balance");

        uint256 amount = value * 10**decimals;
        totalSupply -= amount;
        balances[msg.sender] -= amount;

        emit Transfer(msg.sender, address(0), amount);
        return true;
    }
}