# Keep Pods

- Keep Pods allow smaller Keep owners to delegate a stake lower than the current minimum Keep stake.
- It can be combined with others to reach the current minimum stake and run a node.
- All the Stake is Non-Custodial and Kept in a secure `Escrow Contract`. Users get sKEEP in return of their Keep Token which they can redeem anytime for KEEP tokens.

## Architecture

| Contract          | Work                                         |
| ----------------- | -------------------------------------------- |
| Registry Contract | Handles all Data and Money                   |
| StakingPool       | Delegates Call to `Registry` and `Keep-Core` |
|                   |                                              |

**Registry Contract**
The contract that holds all of the data for pooling as well as KEEP tokens.
It is also the `Beneficiary` and `Owner` contract and receives all the staking rewards.
It cannot be directly called or accessed to prevent data/money loss

**Staking Pool** -
It is responsible for delegating calls to the Registry Contract and Keep-Core Contracts
Validates the input from user and calls appropriate functions for user actions

**sKEEP Contract** -
Tokens user get in return for depositing their KEEP Tokens on our service

## How This Works ?

1. The User comes and deposits his/her KEEP tokens in the `Staking Pool` contract and receives sKEEP tokens in return.
2. The deposit is eligible to get the rewards as soon as a new round starts after he deposits.
3. There is a cooling period of `3 days` after every round where users can withdraw their rewards as well as deposit more tokens or withdraw their existing one.
4. Once a user enters a round their KEEP tokens are locked for a period of 30 days i.e., the duration of the round.
5. After 30 days they can again either enter next round or withdraw their stake.

# Future Works

- Making the Contract completely non-custodial by integrating with a DAO on which a user's sKEEP token will decide their reputation.

<p align="center" >
	<img src="https://i.imgur.com/ycw3Io8.png" alt="argo showcase">
</p>
