pragma solidity >=0.4.22 <0.7.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/math/SafeMath.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "./Interfaces.sol";

contract Registry is Ownable {
    using SafeMath for uint256;
    uint256 public currentRound;

    uint256 public keepBalance;

    uint256 public previousRoundReward;

    address public stakingPoolContract;
    address
        public tokenStakingContract = 0x234d2182B29c6a64ce3ab6940037b5C8FdAB608e;
    address
        public keepTokenContract = 0xb64649fe00f8Ef5187d09d109C6F38f13C7CF857;
    //0xb64649fe00f8Ef5187d09d109C6F38f13C7CF857

    modifier onlyStaking {
        require(
            msg.sender == stakingPoolContract,
            "Call should come from Staking Pool Contract"
        );
        _;
    }

    struct UserTotal {
        uint256 totalUserReward;
        uint256 totalUserStake;
        bool staked;
    }

    struct UserRound {
        uint256 deposit;
        uint256 timestamp;
        bool rewardWithdrawn;
    }

    struct Round {
        uint256 totalStakedAmount;
        uint256 totalRoundReward;
        uint256 balanceRoundReward;
        uint256 balanceStakedAmount;
        uint256 totalUsersPooled; // Number of Users Deposited
        bool withdrawAllowed;
        bool depositAllowed;
    }

    // mapping (uint => Round) public round_data;
    Round[] public round_data;
    mapping(uint256 => mapping(address => UserRound)) public round_user_mapping;
    // (address => UserRound) public user_round;
    //user_round[] public round_user_mapping;

    mapping(address => UserTotal) public user_details;

    function transferRoundReward(address user, uint256 round) public {
        uint256 _stake = round_user_mapping[round][user].deposit;
        uint256 _totalStake = round_data[round].totalStakedAmount;
        uint256 _userReward = round_data[round]
            .totalRoundReward
            .mul(_stake)
            .div(_totalStake);
        round_data[round].balanceRoundReward = round_data[round]
            .balanceRoundReward
            .sub(_userReward);
        round_user_mapping[round][user].rewardWithdrawn = true;
        //substract from total user reward
        IERC20(keepTokenContract).transfer(user, _userReward);
    }

    function getRoundReward(address user, uint256 round)
        public
        view
        returns (uint256)
    {
        uint256 _stake = round_user_mapping[round][user].deposit;
        uint256 _totalStake = round_data[round].totalStakedAmount;
        uint256 _userReward = round_data[round]
            .totalRoundReward
            .mul(_stake)
            .div(_totalStake);

        return _userReward;
    }

    function depositStake(address user, uint256 amount) public {
        IERC20(keepTokenContract).transferFrom(user, address(this), amount);
        if (user_details[user].totalUserStake != 0) {
            user_details[user].totalUserStake = user_details[user]
                .totalUserStake
                .add(amount);
        } else {
            user_details[user] = UserTotal({
                totalUserReward: 0,
                totalUserStake: amount,
                staked: false
            });
        }
    }

    function enterNextRound(address user) public {
        require(user_details[user].staked == false, "Already staked");
        round_data[currentRound].totalStakedAmount = round_data[currentRound]
            .totalStakedAmount
            .add(user_details[user].totalUserStake);
        round_data[currentRound].balanceStakedAmount = round_data[currentRound]
            .balanceStakedAmount
            .add(user_details[user].totalUserStake);
        round_user_mapping[currentRound][user].deposit = user_details[user]
            .totalUserStake;
        user_details[user].staked = true;
    }

    function setLatestRoundReward(uint256 _newReward) public {
        round_data[currentRound].totalRoundReward = _newReward;
        previousRoundReward = _newReward;
    }

    function setNewStakingPoolContract(address _newPoolContract) public {
        stakingPoolContract = _newPoolContract;
    }

    function endCurrentRound(uint256 ongoingRoundReward) public {
        previousRoundReward = ongoingRoundReward;
        round_data[currentRound].withdrawAllowed = true;
        round_data[currentRound].totalRoundReward = ongoingRoundReward;
    }

    function startNewRound() public {
        if (round_data.length == 0) {
            currentRound = 0;
        } else {
            currentRound = currentRound + 1;
        }
        Round memory round = Round(0, 0, 0, 0, 0, false, true);
        round_data.push(round);
    }

    function submitStake(
        address operator,
        address operator_contract,
        bytes memory extraData,
        uint256 amount
    ) public {
        // IERC20(keepTokenContract).approve(operator, round_data[currentRound].totalStakedAmount);
        // send tokens
        IKeepToken(keepTokenContract).approveAndCall(
            address(this),
            amount,
            extraData
        );
        // authorize operator contract
        ITokenStaking(tokenStakingContract).authorizeOperatorContract(
            operator,
            operator_contract
        );
    }
}
