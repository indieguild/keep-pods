pragma solidity >=0.4.22 <0.8.0;

// interface  ITokenStaking {
//     function receiveApproval(
//         address _from,
//         uint256 _value,
//         address _token,
//         bytes calldata _extraData
//     ) external;
//     function undelegate(address _operator) external;
//     function recoverStake(address _operator) external;

// }
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
