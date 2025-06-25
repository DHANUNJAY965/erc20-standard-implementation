// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract ERC20Implementation {
    string public tokenName;
    string public tokenShortName;
    uint8 public tokenDecimals;
    uint256 public totalSupplyrunning;
    address public owner;
    bool private decimalsSet;
    mapping(address => uint256) public Balances;
    mapping(address => mapping(address => uint256)) public allowanceamount;

    event Transfer(address indexed from, address indexed to, uint256 amount);
    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

    constructor(
        string memory tname,
        string memory tsymbol,
        uint8 tdecimals,
        uint256 tinitialSupply
    ) {
        owner = msg.sender;
        tokenName = tname;
        tokenShortName = tsymbol;

        if (tdecimals > 0) {
            tokenDecimals = tdecimals;
            decimalsSet = true;
        }

        totalSupplyrunning = tinitialSupply;
        Balances[owner] = tinitialSupply;
        emit Transfer(address(0), owner, tinitialSupply);
    }
   
}
