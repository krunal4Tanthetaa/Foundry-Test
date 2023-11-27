// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";

contract SignTest is Test {
    // private key = 123
    // public key = vm.addr(private key)
    // message = "secret message"
    // message hash = keccak256(message)
    // vm.sign(private key , message hash)

    function testSignature() public {
        uint256 privateKey = 123;
        address pubKey = vm.addr(privateKey);

        bytes32 messagehash = keccak256("Secret message");

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(privateKey, messagehash);

        address signer = ecrecover(messagehash, v, r, s);

        assertEq(signer, pubKey);

        bytes32 invalidMessageHash = keccak256("Invalid message");
        signer = ecrecover(invalidMessageHash, v, r, s);

        assertTrue(signer != pubKey);
    }
}
