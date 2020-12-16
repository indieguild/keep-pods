import { useCallback, useEffect, useState } from "react";
import { Web3Provider } from "@ethersproject/providers";
import Web3Modal from "web3modal";
import Web3 from "web3";
import WalletConnectProvider from "@walletconnect/web3-provider";

// Enter a valid infura key here to avoid being rate limited
// You can get a key for free at https://infura.io/register
const INFURA_ID = "8b8d0c60bfab43bc8725df20fc660d15";

const NETWORK_NAME = "mainnet";

function useWeb3Modal(config = {}) {
  const [provider, setProvider] = useState(null);
  const [web3, setWeb3] = useState(null);
  const [connected, setConnected] = useState(false);
  const [address, setAddress] = useState(null);
  const [networkId, setNetworkId] = useState(null);

  const {
    autoLoad = true,
    infuraId = INFURA_ID,
    NETWORK = NETWORK_NAME,
  } = config;

  // Web3Modal also supports many other wallets.
  // You can see other options at https://github.com/Web3Modal/web3modal
  const web3Modal = new Web3Modal({
    network: NETWORK,
    cacheProvider: true,
    providerOptions: {
      walletconnect: {
        package: WalletConnectProvider,
        options: {
          infuraId,
        },
      },
    },
  });

  // Open wallet selection modal.
  const loadWeb3Modal = useCallback(async () => {
    const newProvider = await web3Modal.connect();
    
    const web3Inited = new Web3(newProvider);
    
    const accounts = await web3Inited.eth.getAccounts();
    const addressTemp = accounts[0];

    const networkIdTemp = await web3Inited.eth.net.getId();

    setProvider(new Web3Provider(newProvider));
    setWeb3(web3Inited);
    setConnected(true);
    setAddress(addressTemp);
    setNetworkId(networkIdTemp);
  }, [web3Modal]);

  const logoutOfWeb3Modal = useCallback(
    async function() {
      if (web3 && web3.currentProvider && web3.currentProvider.close) {
        await web3.currentProvider.close();
      }
      web3Modal.clearCachedProvider();
      setProvider(null);
      setWeb3(null);
      setConnected(false);
      setAddress(null);
      setNetworkId(null);
    },
    [web3Modal, web3]
  );

  // If user has loaded a wallet before, load it automatically.
  useEffect(() => {
    if (autoLoad && web3Modal.cachedProvider && !connected) {
      loadWeb3Modal();
    }
  }, [autoLoad, loadWeb3Modal, web3Modal.cachedProvider, connected]);

  return {
    provider,
    web3,
    connected,
    address,
    networkId,
    loadWeb3Modal,
    logoutOfWeb3Modal,
  };
}

export default useWeb3Modal;
