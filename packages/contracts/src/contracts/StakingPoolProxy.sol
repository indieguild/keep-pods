pragma solidity >=0.6.0 <0.8.0;

import "@openzeppelin/contracts/proxy/TransparentUpgradeableProxy.sol";
import "./StakingPoolStorage.sol";

contract StakingPoolProxy is TransparentUpgradeableProxy, StakingPoolStorageAdmin{
    constructor(address _logic, address admin_, bytes memory _data) TransparentUpgradeableProxy(_logic, admin_, _data) {}

    function setsKeepAddress(address _sKeepAddress) public ifAdmin {
        skEEP = _sKeepAddress;
    }

    function setTokenStakingContractAddress(address _tokenStakingAddress) public ifAdmin {
        tokenStakingContract = _tokenStakingAddress;
    }

    function setKeepTokenContractAddress(address _keepTokenAddress) public ifAdmin {
        keepTokenContract = _keepTokenAddress;
    }

    function setKeepRandomBeaconOperatorAddress(address _randomBeaconOperatorAddress) public ifAdmin {
        keepRandomBeaconOperatorContract = _randomBeaconOperatorAddress;
    }
}