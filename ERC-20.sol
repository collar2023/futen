pragma solidity ^0.8.0;

// 定义一个名为MyToken的合约
contract MyToken {
    // 映射储存每个地址的代币余额
    mapping(address => uint256) public balances;
    
    // 记录代币总供应量
    uint256 public totalSupply;
    
    // 事件定义，用于通知代币转移
    event Transfer(address indexed from, address indexed to, uint256 value);

    // 构造函数，初始化代币总量并分配给合约创建者
    constructor(uint256 initialSupply) {
        totalSupply = initialSupply;
        balances[msg.sender] = initialSupply;
    }

    // 转移代币函数
    function transfer(address recipient, uint256 amount) public {
        require(amount > 0, "Transfer amount must be greater than zero");
        require(balances[msg.sender] >= amount, "Insufficient balance");

        // 更新余额
        balances[msg.sender] -= amount;
        balances[recipient] += amount;

        // 触发Transfer事件
        emit Transfer(msg.sender, recipient, amount);
    }
}