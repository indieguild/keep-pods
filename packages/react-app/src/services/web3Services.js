import { addresses, abis } from "@project/contracts";
import { getDefaultProvider } from "@ethersproject/providers";
import { Contract } from "@ethersproject/contracts";

let registryContract = null;
let sKeepContract = null;
let stakingPoolContract = null;

export const getsKeepContract = async (defaultProvider) => {
  const sKeepContractInstance = new Contract(
    addresses.sKeepContractAddress,
    abis.erc20,
    defaultProvider
  );

  console.log("sKeepContractInstance", sKeepContractInstance);

  const tokenBalance = await sKeepContractInstance.balanceOf(
    "0x90F8bf6A479f320ead074411a4B0e7944Ea8c9C1"
  );
  console.log({ tokenBalance: tokenBalance.toString() });

  return sKeepContractInstance;
};

export const getKeepContract = async (defaultProvider) => {
  const keepContractInstance = new Contract(
    addresses.keepTokenAddress,
    abis.erc20,
    defaultProvider
  );

  console.log("getKeepContract", keepContractInstance);

  const tokenBalance = await keepContractInstance.balanceOf(
    "0x90F8bf6A479f320ead074411a4B0e7944Ea8c9C1"
  );
  console.log({ tokenBalance: tokenBalance.toString() });

  return keepContractInstance;
};

export const getRegistryContract = async (defaultProvider) => {
  const registryContract = new Contract(
    addresses.registryContractAddress,
    abis.registry,
    defaultProvider
  );

  console.log("getRegistryContract", registryContract);

  return registryContract;
};

export const getStakingPoolContract = async (defaultProvider) => {
  const stakingPoolContract = new Contract(
    addresses.stakingPoolContractAddress,
    abis.stakingPool,
    defaultProvider
  );

  console.log("stakingPoolContract", stakingPoolContract);

  return stakingPoolContract;
};
