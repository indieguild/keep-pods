import React from "react";
import "./Header.scss";
import { shortenAddress } from "../../utils";
import makeBlockie from "ethereum-blockies-base64";
import useWeb3Modal from "../../hooks/useWeb3Modal";
import useCurrentTab from "../../hooks/useCurrentTab";

const Header = () => {
  const {
    provider,
    address,
    loadWeb3Modal,
    logoutOfWeb3Modal,
  } = useWeb3Modal();

  const {tab} = useCurrentTab();

  const getAddressTemplate = (address) => {
    if (address) {
      return (
        <div className="address-container">
          <span>{shortenAddress(address)}</span>
          <img
            src={makeBlockie(address)}
            alt="address blockie"
            className="address-blockie"
          />
        </div>
      );
    } else {
      return (
        <div className="address-container">
          <img
            src={require("../../assets/metamask.svg")}
            alt="metamask icon"
            className="metamask-icon"
          />
          <span>Connect to Wallet</span>
        </div>
      );
    }
  };
  return (
    <div className="Header">
      <div className="header-container">
        <div className="header-title">{tab}</div>
        <div
          className={"wallet-container " + (provider ? "connected" : null)}
          onClick={(e) => (provider ? logoutOfWeb3Modal() : loadWeb3Modal())}
        >
          {getAddressTemplate(address)}
        </div>
      </div>
    </div>
  );
};

export default Header;
