pragma solidity >=0.6.0 <0.8.0;

contract StakingPoolStorageAdmin {
    // address public tokenStakingContract = 0x234d2182B29c6a64ce3ab6940037b5C8FdAB608e;
    // address public keepTokenContract = 0x343d3DDA00415289CDD4E8030F63a4A5a2548ff9;
    // address public skEEP = 0xaC437A49AB06Ae631d5B2600169a4202BCDe4419;
    // address public keepRandomBeaconOperatorContract = 0xC8337a94a50d16191513dEF4D1e61A6886BF410f;
    address public tokenStakingContract;
    address public keepTokenContract;
    address public skEEP;
    address public keepRandomBeaconOperatorContract;
}

contract StakingPoolStorageV1 is StakingPoolStorageAdmin{
    uint256 public currentRound;

    uint256 public keepBalance;

    uint256 public previousRoundReward;

    address public stakingPoolContract;
    
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

    Round[] public round_data;
    
    mapping(address => UserRound)[] public round_user_mapping;

    mapping(address => UserTotal) public user_details;
}