// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function transfer(address recipient, uint256 amount) external returns (bool);
}

contract SimpleStaking {
    IERC20 public token;
    uint256 public lockTime = 1 days;

    struct StakeInfo {
        uint256 amount;
        uint256 timestamp;
    }

    mapping(address => StakeInfo) public stakes;

    constructor(address _token) {
        token = IERC20(_token);
        token1 = IERC20(_token1);

    }

    function stake(uint256 _amount) external {
        require(_amount > 0, "Amount must be > 0");
        require(stakes[msg.sender].amount == 0, "Already staked");
        // Min 10
        // Max 100

        token.transferFrom(msg.sender, address(this), _amount);

        stakes[msg.sender] = StakeInfo({
            amount: _amount,
            timestamp: block.timestamp
        });
    }

    function withdraw() external {
        //Max 100
        StakeInfo storage userStake = stakes[msg.sender];
        require(userStake.amount > 0, "Nothing to withdraw");
        require(block.timestamp >= userStake.timestamp + lockTime, "Stake is still locked");
                                
        uint256 amount = userStake.amount;
        delete stakes[msg.sender];
        token.transfer(msg.sender, amount);
    }

    function pool(uint _n) 
}
