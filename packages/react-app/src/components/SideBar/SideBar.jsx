import React from "react";
import "./SideBar.scss";
import { Link } from "react-router-dom";

const SideBar = () => {
  return (
    <div className="SideBar">
      <div className="side-bar-header">
        <Link to="/" className="logo-text-container">
          KeepPod.
        </Link>
      </div>
      <div className="side-bar-list-container">
        <div className="side-bar-list-item">Overview</div>
        <div className="side-bar-list-item">Manage Stake</div>
        <div className="side-bar-list-item">Rewards</div>
      </div>
    </div>
  );
};

export default SideBar;
