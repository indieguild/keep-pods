pragma solidity >=0.6.0 <0.8.0;

interface ITokenStaking {
    function authorizeOperatorContract(
        address _operator,
        address _operatorContract
    ) external;

    function isAuthorizedForOperator(
        address _operator,
        address _operatorContract
    ) external view returns (bool);
}

interface IKeepToken {
    function approveAndCall(
        address _spender,
        uint256 _value,
        bytes calldata _extraData
    ) external returns (bool);
}
