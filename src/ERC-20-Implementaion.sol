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
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    function name() public view returns (string memory) {
        return tokenName;
    }
    function symbol() public view returns (string memory) {
        return tokenShortName;
    }

    function decimals() public view returns (uint8) {
        return tokenDecimals;
    }
    function totalSupply() public view returns (uint256) {
        return totalSupplyrunning;
    }

     function balanceOf(address add) public view returns (uint256 balance) {
        require(add != address(0), "Cannot find balance of zero address");
        return Balances[add];
    }

    function transfer(address to, uint256 amount) public returns (bool) {
        require(to != address(0), "No transfers to zero address");
        require(Balances[msg.sender] >= amount, "Balance is insufficient");
        Balances[msg.sender] -= amount;
        Balances[to] += amount;
        emit Transfer(msg.sender, to, amount);
        return true;
    }

     function mint(address to, uint256 amount) public onlyOwner returns (bool) {
        require(msg.sender == owner, "Only owner can mint");
        Balances[to] += amount;
        totalSupplyrunning += amount;
        emit Transfer(address(0), msg.sender, amount);
        return true;
    }

    function burn(uint256 amount) public onlyOwner returns (bool) {
        require(Balances[msg.sender] >= amount, "Insufficient balance to burn");
        Balances[msg.sender] -= amount;
        totalSupplyrunning -= amount;
        emit Transfer(msg.sender, address(0), amount);
        return true;
    }

    function allowance(
        address from,
        address beneficiary
    ) public view returns (uint256 remaining) {
        require(from != address(0), "No allowance to zero address");
        require(beneficiary != address(0), "No allowance to zero address");
        return allowanceamount[from][beneficiary];
    }

     function approve(
        address beneficiary,
        uint256 amount
    ) public returns (bool success) {
        require(beneficiary != address(0), "No transfers to zero address");
        allowanceamount[msg.sender][beneficiary] = amount;
        emit Approval(msg.sender, beneficiary, amount);
        return true;
    }

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public returns (bool success) {
        require(to != address(0), "No transfers to zero address");
        uint256 currentAllowance = allowanceamount[from][msg.sender];
        require(currentAllowance >= amount, "Allowance is insufficient");
        allowanceamount[from][msg.sender] = currentAllowance - amount;
        Balances[from] -= amount;
        Balances[to] += amount;
        emit Transfer(from, to, amount);
        return true;
    }
    function setDecimals(uint8 tdecimals) public {
        require(!decimalsSet, "Decimals already set");
        tokenDecimals = tdecimals;
        decimalsSet = true;
    }

     function allowanceincrease(
        address beneficiary,
        uint256 amount
    ) public returns (bool) {
        require(beneficiary != address(0), "No transfers to zero address");
        allowanceamount[msg.sender][beneficiary] += amount;
        emit Approval(
            msg.sender,
            beneficiary,
            allowanceamount[msg.sender][beneficiary]
        );
        return true;
    }

    function allowancedecrease(
        address beneficiary,
        uint256 amount
    ) public returns (bool) {
        require(beneficiary != address(0), "No transfers to zero address");
        require(
            allowanceamount[msg.sender][beneficiary] >= amount,
            "Insufficient allowance to decrease"
        );
        allowanceamount[msg.sender][beneficiary] -= amount;
        emit Approval(
            msg.sender,
            beneficiary,
            allowanceamount[msg.sender][beneficiary]
        );
        return true;
    }
}
