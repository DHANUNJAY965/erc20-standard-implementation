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
}
