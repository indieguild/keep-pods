import React from "react";
import "./SideBar.scss";
import { Link } from "react-router-dom";
import useCurrentTab from "../../hooks/useCurrentTab";

const SideBar = () => {

  const {tab} = useCurrentTab();

  return (
    <div className="SideBar">
      <div className="side-bar-header">
        <Link to="/" className="logo-text-container">
          KeepPod.
        </Link>
      </div>
      <div className="side-bar-list-container">
        <Link className={`side-bar-list-item ${tab === "Overview" ? "selected-list-item": ""}`} to="/overview">Overview</Link>
        <Link className={`side-bar-list-item ${tab === "Manage Stake" ? "selected-list-item": ""}`} to="/manage-stake">Manage Stake</Link>
        <Link className={`side-bar-list-item ${tab === "Rewards" ? "selected-list-item": ""}`} to="/rewards">Rewards</Link>
      </div>
    </div>
  );
};

export default SideBar;
