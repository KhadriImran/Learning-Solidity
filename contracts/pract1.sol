pragma solidity ^0.8.0;

contract DefaultValues {
    uint public myUint;
    bool public myBool;
    address public myAddress;

    function getValues() public view returns (uint, bool, address) {
        return (myUint, myBool, myAddress);
    }
}