import React from "react";
import "./ManageStake.scss";
import TextField from "@material-ui/core/TextField";

const ManageStake = () => {
  return (
    <div className="ManageStake">
      <div className="overview-details">
        <div className="overview-card">
          <div className="overview-card-header">
            <h3 className="overview-card-title">Current Pool</h3>
            <div className="overview-card-time">
              <span>
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none">
                  <path
                    fillRule="evenodd"
                    clipRule="evenodd"
                    d="M0 12C0 5.37258 5.37258 0 12 0C18.6274 0 24 5.37258 24 12C24 18.6274 18.6274 24 12 24C5.37258 24 0 18.6274 0 12ZM12 1.6C6.25624 1.6 1.6 6.25624 1.6 12C1.6 17.7438 6.25624 22.4 12 22.4C17.7438 22.4 22.4 17.7438 22.4 12C22.4 6.25624 17.7438 1.6 12 1.6ZM12 7.2C12.4418 7.2 12.8 7.55817 12.8 8V11.6687L17.5652 16.4349C17.8776 16.7474 17.8775 17.2539 17.5651 17.5663C17.2526 17.8787 16.7461 17.8786 16.4337 17.5662L11.4343 12.5656C11.2843 12.4156 11.2 12.2121 11.2 12V8C11.2 7.55817 11.5582 7.2 12 7.2Z"
                    fill="#787878"
                  ></path>
                </svg>
              </span>
              <span>12:20:42:10</span>
            </div>
          </div>
          <div className="overview-card-body-container">
            <span>
              <svg
                className="keep-outline"
                width="35"
                height="35"
                viewBox="0 0 35 35"
                fill="none"
              >
                <path
                  d="M17.5 1.4C26.3667 1.4 33.6 8.63333 33.6 17.5C33.6 26.3667 26.3667 33.6 17.5 33.6C8.63333 33.6 1.4 26.3667 1.4 17.5C1.4 8.63333 8.63333 1.4 17.5 1.4ZM17.5 0C7.84 0 0 7.84 0 17.5C0 27.16 7.84 35 17.5 35C27.16 35 35 27.16 35 17.5C35 7.84 27.16 0 17.5 0ZM24.85 13.6033H23.7533L20.3933 17.5L23.73 21.3967H24.8267V24.5233H17.7567V21.4433H18.8533L16.66 18.9H15.75V21.4433H16.9867V24.5467H10.15V21.3967H11.6433V17.5V13.6033H10.15V10.4533H11.83V11.62H12.74V10.4533H14.3967V11.62H15.3067V10.4533H16.9867V13.5567H15.75V16.1H16.66L18.8533 13.5567H17.7567V10.4533H24.85V13.6033V13.6033Z"
                  fill="#48DBB4"
                ></path>
              </svg>
            </span>
            <span>0.0 KEEP</span>
          </div>
        </div>
        <div className="overview-card">
          <div className="overview-card-header">
            <h3 className="overview-card-title">Your Stake</h3>
          </div>
          <div className="overview-card-body-container">
            <span>
              <svg
                className="keep-outline"
                width="35"
                height="35"
                viewBox="0 0 35 35"
                fill="none"
              >
                <path
                  d="M17.5 1.4C26.3667 1.4 33.6 8.63333 33.6 17.5C33.6 26.3667 26.3667 33.6 17.5 33.6C8.63333 33.6 1.4 26.3667 1.4 17.5C1.4 8.63333 8.63333 1.4 17.5 1.4ZM17.5 0C7.84 0 0 7.84 0 17.5C0 27.16 7.84 35 17.5 35C27.16 35 35 27.16 35 17.5C35 7.84 27.16 0 17.5 0ZM24.85 13.6033H23.7533L20.3933 17.5L23.73 21.3967H24.8267V24.5233H17.7567V21.4433H18.8533L16.66 18.9H15.75V21.4433H16.9867V24.5467H10.15V21.3967H11.6433V17.5V13.6033H10.15V10.4533H11.83V11.62H12.74V10.4533H14.3967V11.62H15.3067V10.4533H16.9867V13.5567H15.75V16.1H16.66L18.8533 13.5567H17.7567V10.4533H24.85V13.6033V13.6033Z"
                  fill="#48DBB4"
                ></path>
              </svg>
            </span>
            <span>0.0 KEEP</span>
          </div>
        </div>
      </div>
      <div className="overview-details">
        <div className="overview-card">
          <div className="overview-card-middle-header">
            <h3 className="overview-card-title">Deposit Stake</h3>
          </div>
          <div className="overview-card-button-container">
            <TextField
              label="Stake Amount"
              variant="filled"
              placeholder="Enter here KEEP"
              size="small"
              type="number"
              fullWidth
            />
          </div>
          <div className="overview-card-button-container">
            <button className="staking-button">Deposit</button>
          </div>
        </div>
        <div className="overview-card">
          <div className="overview-card-middle-header">
            <h3 className="overview-card-title">Withdraw Stake</h3>
          </div>
          <div className="overview-card-button-container">
            <TextField
              label="Withdraw Amount"
              variant="filled"
              placeholder="Enter here KEEP"
              size="small"
              type="number"
              fullWidth
            />
          </div>
          <div className="overview-card-button-container">
            <button className="staking-button">Withdraw</button>
          </div>
        </div>
      </div>
    </div>
  );
};

export default ManageStake;
