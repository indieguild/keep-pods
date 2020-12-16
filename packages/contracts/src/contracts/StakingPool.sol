pragma solidity >=0.4.22 <0.7.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./Registry.sol";
import "./sKEEP.sol";

contract StakingPool is Ownable {

    using SafeMath for uint;
    address public sKeepContract;
    address public registryContract;
    address public daoContract;
    address public registryContract;
    
    Registry registryInstance = new Registry(registryContract);
    sKEEP sKeepToken = new sKEEP(sKeepContract);

    constructor () public {
    }

    function setRegistry(address _registry) public onlyOwner{
        registryContract = _registry;
    }

    function setKeep(address _keepToken) public onlyOwner{
        sKeepContract = _keepToken;
    }

    function depositTokenForNextRound(uint _amount) public {
        uint currentRound = registryInstance.currentRound();
        registryInstance.depositStake(msg.sender, _amount);
        // enter User into the next Round
    }

    function withdrawStakeAmount() public {
        
    }

    function withdrawStakeWithRewards() public {

    }

    function withdrawRewardsForPreviousRound() public {
        uint currentRound = registryInstance.currentRound();
        registryInstance.transferRoundReward(msg.sender, currentRound);
    }

    function withdrawRewardsForAllRounds() public {

    }

    function getRewardForPreviousRound() public view{
        uint currentRound = registryInstance.currentRound();
        registryInstance.getRoundReward(msg.sender, currentRound);
    }

    function enterNextRound() public {
        regsitryInstance.enterNextRound(msg.sender)
    }

    function endCurrentRound() public {
        registryInstance.endCurrentRound()
    }

    function startNewRound() public {
        regsitryInstance.startNewRound()
    }


    // Call to KEEP Core Contracts
    function delegateTokensToKeepContract() public {

    }

    function authorizeOperatorToStake() public {

    }
    
    function withdrawPreviousRoundReward() public {

    }
}

