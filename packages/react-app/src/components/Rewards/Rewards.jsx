import React from "react";
import "./Rewards.scss";
import Table from "@material-ui/core/Table";
import TableBody from "@material-ui/core/TableBody";
import TableCell from "@material-ui/core/TableCell";
import TableContainer from "@material-ui/core/TableContainer";
import TableHead from "@material-ui/core/TableHead";
import TableRow from "@material-ui/core/TableRow";
import Paper from "@material-ui/core/Paper";
const Rewards = () => {
  return (
    <div className="Rewards">
      <div className="overview-details middle-card">
        <div className="overview-card">
          <div className="overview-card-middle-header">
            <h3 className="overview-card-title">Current Reward</h3>
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
          <div className="overview-card-button-container">
            <button className="staking-button">Withdraw Rewards</button>
          </div>
        </div>
      </div>
      <div className="reward-list">
        <div className="overview-card">
          <div className="reward-card-header">
            <h3 className="reward-card-title">Current Reward</h3>
          </div>

          <TableContainer component={Paper}>
            <Table aria-label="simple table">
              <TableHead className="table-head">
                <TableRow>
                  <TableCell className="table-head">
                    Dessert (100g serving)
                  </TableCell>
                  <TableCell className="table-head" align="right">
                    Calories
                  </TableCell>
                  <TableCell className="table-head" align="right">
                    Fat&nbsp;(g)
                  </TableCell>
                  <TableCell className="table-head" align="right">
                    Carbs&nbsp;(g)
                  </TableCell>
                  <TableCell className="table-head" align="right">
                    Protein&nbsp;(g)
                  </TableCell>
                </TableRow>
              </TableHead>
              <TableBody>
                <TableRow>
                  <TableCell>Dessert (100g serving)</TableCell>
                  <TableCell align="right">Calories</TableCell>
                  <TableCell align="right">Fat&nbsp;(g)</TableCell>
                  <TableCell align="right">Carbs&nbsp;(g)</TableCell>
                  <TableCell align="right">Protein&nbsp;(g)</TableCell>
                </TableRow>
              </TableBody>
            </Table>
          </TableContainer>
        </div>
      </div>
    </div>
  );
};

export default Rewards;
