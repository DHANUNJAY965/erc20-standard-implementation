// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import {Test, console} from "forge-std/Test.sol";
import {ERC20Implementation} from "../src/ERC-20-Implementaion.sol";

contract Erc20 is Test {
     ERC20Implementation public token;

    function setUp() public {
        token = new ERC20Implementation("dhanuToken","DHT",0,1000);
    }
    function testInitialSupply() public view {
        assertEq(token.totalSupplyrunning(), 1000);
        assertEq(token.Balances(address(this)), 1000);
    }

    function testName() public view {
        assertEq(token.name(), "dhanuToken", "Token name does not match");
    }

    function testSymbol() public view {
        assertEq(token.symbol(), "DHT", "Token symbol does not match");
    }
    function testDecimals() public view {
        assertEq(token.decimals(), 0, "Token decimals does not match");
    }

    function testTotalSupply() public view {
        assertEq(token.totalSupply(), 1000, "total supply not equal to 1000");
    }

     function testTransfer() public {
        // console.log("Initial total supply: ", token.totalSupplyrunning());
        // console.log("Contract address : ", address(this));
        // console.log("Initial balance of contract: ", token.Balances(address(this)));
        assertEq(token.Balances(address(this)), 1000);
        token.transfer(0xA68A8adC1F6AB80010fa3189908E908C8F1a40bF, 100);
        assertEq(token.Balances(address(this)), 900);
        assertEq(token.totalSupplyrunning(), 1000);
    }

    function testMint() public {
        console.log("Initial total supply: ", token.totalSupplyrunning());
        console.log("Contract address : ", address(this));
        console.log(
            "Initial balance of contract: ",
            token.Balances(token.owner())
        );
        assertEq(token.Balances(token.owner()), 1000);
        token.mint(address(this), 500);
        assertEq(token.totalSupplyrunning(), 1500);
        assertEq(token.Balances(token.owner()), 1500);
    }

    function testBurn() public {
        console.log("Initial total supply: ", token.totalSupplyrunning());
        console.log("Contract address : ", address(this));
        console.log(
            "Initial balance of contract: ",
            token.Balances(token.owner())
        );
        assertEq(token.Balances(token.owner()), 1000);
        token.burn(500);
        assertEq(token.totalSupplyrunning(), 500);
        assertEq(token.Balances(token.owner()), 500);
    }

    function testApprove() public {
        uint256 amount = 2000;
        bool issuccesstoken = token.approve(
            0xA68A8adC1F6AB80010fa3189908E908C8F1a40bF,
            amount
        );
        assertTrue(issuccesstoken, "approve function did not return true");
        assertEq(
            token.allowance(
                token.owner(),
                0xA68A8adC1F6AB80010fa3189908E908C8F1a40bF
            ),
            amount,
            "allowance is not equal to amount"
        );
    }

    
     function testTransferFrom() public {
        address owner = address(this);
        bool isapprovesuccess = token.approve(
            0xA68A8adC1F6AB80010fa3189908E908C8F1a40bF,
            500
        );
        assertTrue(isapprovesuccess, "approve function did not return true");
        vm.startPrank(0xA68A8adC1F6AB80010fa3189908E908C8F1a40bF);
        bool istransferfromsuccess = token.transferFrom(
            owner,
            0x4838B106FCe9647Bdf1E7877BF73cE8B0BAD5f97,
            200
        );
        assertTrue(
            istransferfromsuccess,
            "transferFrom function did not return true"
        );
        assertEq(
            token.allowance(owner, 0xA68A8adC1F6AB80010fa3189908E908C8F1a40bF),
            300,
            "allowance is not equal to amount"
        );
        assertEq(token.Balances(owner), 800, "balance is not equal to amount");
        assertEq(
            token.Balances(0x4838B106FCe9647Bdf1E7877BF73cE8B0BAD5f97),
            200,
            "balance is not equal to amount"
        );
        vm.stopPrank();
    }


    function testAllowancebalance() public {
        bool issuccesstoken = token.approve(
            0xA68A8adC1F6AB80010fa3189908E908C8F1a40bF,
            500
        );
        assertTrue(issuccesstoken, "approve function did not return true");
        assertEq(
            token.allowance(
                address(this),
                0xA68A8adC1F6AB80010fa3189908E908C8F1a40bF
            ),
            500,
            "allowance is not equal to amount"
        );
    }

      function testAllowanceIncrease() public {
       bool isSuccess = token.approve(
            0xA68A8adC1F6AB80010fa3189908E908C8F1a40bF,
            500
        );
        assertTrue(isSuccess, "approve function did not return true");
        uint256 initialAllowance = token.allowance(
            address(this),
            0xA68A8adC1F6AB80010fa3189908E908C8F1a40bF
        );
        token.allowanceincrease(
            0xA68A8adC1F6AB80010fa3189908E908C8F1a40bF,
            200
        );
        assertEq(
            token.allowance(
                address(this),
                0xA68A8adC1F6AB80010fa3189908E908C8F1a40bF
            ),
            initialAllowance + 200,
            "allowance not credited"
        );
    }
    function testAllowanceDecrease() public {
        bool isSuccess = token.approve(
            0xA68A8adC1F6AB80010fa3189908E908C8F1a40bF,
            500
        );
        assertTrue(isSuccess, "approve function did not return true");
        uint256 initialAllowance = token.allowance(
            address(this),
            0xA68A8adC1F6AB80010fa3189908E908C8F1a40bF
        );
        token.allowancedecrease(
            0xA68A8adC1F6AB80010fa3189908E908C8F1a40bF,
            200
        );
        assertEq(
            token.allowance(
                address(this),
                0xA68A8adC1F6AB80010fa3189908E908C8F1a40bF
            ),
            initialAllowance - 200,
            "allowance not debited"
        );
    }

    
}
