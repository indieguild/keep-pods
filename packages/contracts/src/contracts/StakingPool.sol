pragma solidity >=0.4.22 <0.7.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/math/SafeMath.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "./Registry.sol";
import "./sKEEP.sol";

contract StakingPool is Ownable {
    using SafeMath for uint256;
    address public sKeepContract;
    address public registryContract;
    address public daoContract;

    Registry registryInstance = Registry(registryContract);
    sKEEP sKeepToken = sKEEP(sKeepContract);

    constructor(address registryAddress) public {
        registryContract = registryAddress;
    }

    function setRegistry(address _registry) public onlyOwner {
        registryContract = _registry;
    }

    function setKeep(address _keepToken) public onlyOwner {
        sKeepContract = _keepToken;
    }

    function depositTokenForNextRound(uint256 _amount) public {
        // uint currentRound = registryInstance.currentRound();
        registryInstance.depositStake(msg.sender, _amount);
        // enter User into the next Round
    }

    function withdrawStakeAmount() public {}

    function withdrawStakeWithRewards() public {}

    function withdrawRewardsForPreviousRound() public {
        uint256 currentRound = registryInstance.currentRound();
        registryInstance.transferRoundReward(msg.sender, currentRound);
    }

    function withdrawRewardsForAllRounds() public {}

    function getRewardForPreviousRound() public view {
        uint256 currentRound = registryInstance.currentRound();
        registryInstance.getRoundReward(msg.sender, currentRound);
    }

    function enterNextRound() public {
        registryInstance.enterNextRound(msg.sender);
    }

    function endCurrentRound() public {
        uint256 ongoingRoundReward = 0;
        registryInstance.endCurrentRound(ongoingRoundReward);
    }

    function startNewRound() public {
        registryInstance.startNewRound();
    }

    // Call to KEEP Core Contracts
    function delegateTokensToKeepContract() public {}

    function authorizeOperatorToStake() public {}

    function withdrawPreviousRoundReward() public {}
}
