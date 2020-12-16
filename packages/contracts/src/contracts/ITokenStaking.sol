pragma solidity >=0.4.22 <0.7.0;

interface  ITokenStaking {
    function receiveApproval(
        address _from,
        uint256 _value,
        address _token,
        bytes calldata _extraData
    ) external;
    function undelegate(address _operator) external;
    function recoverStake(address _operator) external;


}
interface IAuthorization {
    function authorizeOperatorContract(address _operator, address _operatorContract) external;
    function isAuthorizedForOperator(
        address _operator,
        address _operatorContract
    ) external view returns (bool);
}