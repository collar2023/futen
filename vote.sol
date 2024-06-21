pragma solidity ^0.7.0;

contract SimpleVoting {
    // 投票者列表
    mapping(address => bool) public voters;
    
    // 候选人列表
    string[] public candidates;
    
    // 记录每个候选人获得的票数
    mapping(string => uint256) public votesReceived;
    
    // 构造函数，初始化候选人列表
    constructor(string[] memory _candidates) public {
        candidates = _candidates;
    }
    
    // 投票函数
    function vote(string memory _candidate) public {
        // 检查投票者是否已投票
        require(!voters[msg.sender], "You have already voted.");
        require(isValidCandidate(_candidate), "Invalid candidate.");
        
        // 标记投票者已投票
        voters[msg.sender] = true;
        
        // 给候选人增加票数
        votesReceived[_candidate] += 1;
        
        // 触发投票事件
        emit Voted(msg.sender, _candidate);
    }
    
    // 检查候选人是否有效
    function isValidCandidate(string memory _candidate) view internal returns (bool) {
        for(uint i = 0; i < candidates.length; i++) {
            if (stringEqual(candidates[i], _candidate)) return true;
        }
        return false;
    }
    
    // 辅助函数，比较两个字符串是否相等
    function stringEqual(string memory a, string memory b) internal pure returns (bool) {
        return keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b)));
    }
    
    // 投票事件
    event Voted(address indexed voter, string indexed candidate);
}