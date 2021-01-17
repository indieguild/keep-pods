pragma solidity >=0.6.0 <0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "./sKEEP.sol";
import "./StakingPoolStorage.sol";
import "./Interfaces.sol";

contract StakingPool is StakingPoolStorageV1 {

    using SafeMath for uint;
    
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
        sKEEP(skEEP).mint(
            msg.sender,
            amount
        );
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
        // address operator_contract,
        bytes memory extraData,
        uint256 amount
    ) public {
        // IERC20(keepTokenContract).approve(operator, round_data[currentRound].totalStakedAmount);
        //send tokens
        IKeepToken(keepTokenContract).approveAndCall(
            tokenStakingContract,
            amount,
            extraData
        );
        // authorize operator contract
        ITokenStaking(tokenStakingContract).authorizeOperatorContract(
            operator,
            keepRandomBeaconOperatorContract
        );
    }
    function withdraw (address addr, uint amt)public {
        IERC20(keepTokenContract).transfer(addr, amt);
    }
}