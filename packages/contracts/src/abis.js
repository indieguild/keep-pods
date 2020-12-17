import erc20Abi from "./abis/erc20.json";
import ownableAbi from "./abis/ownable.json";
import sKEEPAbi from "./build/sKEEP.json";
import registryAbi from "./build/Registry.json";
import stakingPoolAbi from "./build/StakingPool.json";

const abis = {
  erc20: erc20Abi,
  ownable: ownableAbi,
  sKEEP: sKEEPAbi,
  registry: registryAbi,
  stakingPool: stakingPoolAbi
};

export default abis;
