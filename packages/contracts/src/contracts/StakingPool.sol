pragma solidity >=0.4.22 <0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./Registry.sol";
import "./sKEEP.sol";
import "./Interfaces.sol";

contract StakingPool is Ownable {
    using SafeMath for uint256;
    address public sKeepContract;
    address public registryContract;
    address public daoContract;

    Registry registryInstance;

    constructor(address registryAddress) public {
        registryContract = registryAddress;
        registryInstance = Registry(registryContract);
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
        sKEEP(0xBCB388429F009231b528f35CefF26A390Cf0d569).mint(
            msg.sender,
            _amount
        );
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

    function enterAndDeposit(uint256 _amount) public {
        // uint currentRound = registryInstance.currentRound();
        registryInstance.depositStake(msg.sender, _amount);
        // enter User into the next Round
        sKEEP(0xBCB388429F009231b528f35CefF26A390Cf0d569).mint(
            msg.sender,
            _amount
        );
        registryInstance.enterNextRound(msg.sender);
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
    function delegateTokensToKeepContract(
        address operator,
        // address operator_contract,
        bytes memory extraData,
        uint256 amount
    ) public {
        registryInstance.submitStake(operator, extraData, amount);
    }

    function authorizeOperatorToStake() public {}

    function withdrawPreviousRoundReward() public {}
}
