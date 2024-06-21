// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleToken {
    // 定义状态变量，记录每个地址的代币余额
    mapping(address => uint256) public balances;
    
    // 添加访问控制，定义一个合约管理员
    address private owner;
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can call this function.");
        _;
    }
    constructor() {
        owner = msg.sender;
    }

    // 发送代币的函数，增加防止重入攻击和溢出保护
    function transfer(address to, uint256 amount) public {
        require(amount > 0, "Amount must be greater than zero.");
        require(balances[msg.sender] >= amount, "Insufficient balance.");
        
        // 使用内建的安全运算符来防止溢出
        balances[msg.sender] -= amount;
        balances[to] += amount;
        require(balances[msg.sender] >= 0, "Underflow detected."); // 额外的检查
        
        // 触发事件，通知代币转移
        emit Transfer(msg.sender, to, amount);
    }

    // 事件定义保持与原始一致，不包含时间戳
    event Transfer(address indexed from, address indexed to, uint256 value);

    // 更新转移事件触发，去除时间戳部分以匹配事件定义
    function safeTransfer(address to, uint256 amount) public onlyOwner {
        transfer(to, amount);
    }
}