/**
 *Submitted for verification at amoy.polygonscan.com on 2025-04-16
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
interface IERC20 {
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function transfer(address recipient, uint256 amount) external returns (bool);

}

contract SimpleStaking {
    IERC20 public token;
    IERC20 public token1;
    uint256 public lockTime = 1 days;

    struct StakeInfo {
        uint256 amount;
        uint256 timestamp;
    }

    struct Pool{
        uint256 _n;
        address addr;
    }
   

    mapping(address => StakeInfo) public stakes;
    constructor(address _token, address _token1) {
        token = IERC20(_token);
        token1=IERC20(_token1);
    }

    function stake(uint256 _amount) external {
        require(_amount >= 10,"Amount must be > 10");
        require(_amount <= 100,"Amount must be <= 100" );
        require(stakes[msg.sender].amount == 0, "Already staked");

        token.transferFrom(msg.sender, address(this), _amount);

        stakes[msg.sender] = StakeInfo({
            amount: _amount,
            timestamp: block.timestamp
        });
    }

    function withdraw(uint _amount) external {
        
        StakeInfo storage userStake = stakes[msg.sender];

        require(_amount <= 100);
        require(block.timestamp >= userStake.timestamp + lockTime, "Stake is still locked");

        uint256 amount = _amount;
        delete stakes[msg.sender];
        token.transfer(msg.sender, amount);
        
    }
    mapping(address => Pool) public pools;

    function pool(uint _n) public {
        require(_n >= 10,"Amount must be > 10");
        require(_n <= 100,"Amount must be <= 100" );
        token.transferFrom(msg.sender, address(this), _n);
        token1.transferFrom(msg.sender, address(this), _n);

    }
    
    
}