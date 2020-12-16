pragma solidity >=0.4.22 <0.7.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract Registry is Ownable{

    using SafeMath for uint;
    uint public currentRound;
    
    uint public keepBalance;
    
    uint public previousRoundReward;

    address public stakingPoolContract;

    struct UserTotal {
        uint totalUserReward;
        uint totalUserStake;
        bool staked;
    }

    struct UserRound {
        uint deposit;
        uint timestamp;
        bool rewardWithdrawn;
    }

    struct Round {
        uint totalStakedAmount;
        uint totalRoundReward;
        uint balanceRoundReward;
        uint balanceStakedAmount;
        uint totalUsersPooled; // Number of Users Deposited

        bool withdrawAllowed;
        bool depositAllowed;
    }

    // mapping (uint => Round) public round_data;
    Round[] public round_data;
    mapping (uint => mapping(address => UserRound)) public round_user_mapping;
     // (address => UserRound) public user_round;
    //user_round[] public round_user_mapping;
    
    mapping (address => UserTotal) public user_details;

    constructor () public {
        
    }

    address Keep = 0x90F8bf6A479f320ead074411a4B0e7944Ea8c9C1;
    function transferRoundReward(address user, uint round) public {
        require(msg.sender == stakingPoolContract, "Not a Valid Call, should be called from staking contract");
        uint _stake = round_user_mapping[round][user].deposit;
        uint _totalStake = round_data[round].totalStakedAmount;
        uint _userReward = round_data[round].totalRoundReward.mul(_stake).div(_totalStake);
        round_data[round].balanceRoundReward = round_data[round].balanceRoundReward.sub(_userReward);
        round_user_mapping[round][user].rewardWithdrawn = true;
        //substract from total user reward
        IERC20(Keep).transfer(user, _userReward);
        
    }

    function getRoundReward(address user, uint round) public view {
        uint _stake = round_user_mapping[round][user].deposit;
        uint _totalStake = round_data[round].totalStakedAmount;
        uint _userReward = round_data[round].totalRoundReward.mul(_stake).div(_totalStake);

        return _userReward;
    }

    function depositStake(address user, uint amount) public {
        require(msg.sender == stakingPoolContract, "Not a Valid Call, should be called from staking contract");
        IERC20(Keep).transferFrom(user, address(this), amount);
        if(user_details[user].totalUserStake != 0){
            user_details[user].totalUserStake = user_details[user].totalUserStake.add(amount);
        }else {
            user_details[user] = UserTotal({
                totalUserReward: amount,
                totalUserStake: 0
            });
        }
     
    }

    function enterNextRound(address user) public {
        require(msg.sender == stakingPoolContract, "Not a Valid Call, should be called from staking contract");
        require(user_details[user].staked == false, "Already staked");
        round_data[currentRound].totalStakedAmount = round_data[currentRound].totalStakedAmount.add(user_details[user].totalUserReward);
        round_data[currentRound].balanceStakedAmount = round_data[currentRound].balanceStakedAmount.add(user_details[user].totalUserReward);
        round_user_mapping[currentRound][user] = user_details[user].totalUserReward;
        user_details[user].staked = true;
    }

    function setLatestRoundReward (uint _newReward) public {
            require(msg.sender == stakingPoolContract, "Not a Valid Call, should be called from staking contract");
            round_data[currentRound].totalRoundReward = _newReward;
            previousRoundReward = _newReward;
    }

    function setNewStakingPoolContract (address _newPoolContract) public {
        require(msg.sender == stakingPoolContract, "Not a Valid Call, should be called from staking contract");
        stakingPoolContract = _newPoolContract;
    }

    function endCurrentRound(uint ongoingRoundReward) public {
        previousRoundReward = ongoingRoundReward;
        round_data[currentRound].withdrawAllowed = true;
        round_data[currentRound].totalRoundReward = ongoingRoundReward;
    }

    function startNewRound() public {
        require(msg.sender == stakingPoolContract, "Not a Valid Call, should be called from staking contract");

        uint newRound = currentRound++;
        currentRound = newRound;
        round_data[newRound] =  Round(0,0,0,0,0,false);
    }

    function submitStake(address operator) public {
        IERC20(Keep).approve(operator, round_data[currentRound].totalStakedAmount);
        // todo authorize
        
        
    }
}

