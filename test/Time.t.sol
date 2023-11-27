// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import {Auction} from "../src/Time.sol";

contract TimeTest is Test {
    Auction public auction;
    uint256 private startAt;

    // vm.warp = set block.timestamp to future timestamp
    // vm.roll = set block.number
    // skip = increment current timestamp
    // rewide = decrement current timestamp

    function setUp() public {
        auction = new Auction();
        startAt = block.timestamp;
    }

    function testBidF() public {
        vm.expectRevert(bytes("cannot bid"));
        auction.bid();
    }

    function testBid() public {
        vm.warp(startAt + 1 days);
        auction.bid();
    }

    function testEnd() public {
        vm.warp(startAt + 2 days);
        auction.end();
    }

    function testSkipRewind() public {
        skip(100);
        assertEq(block.timestamp, startAt + 100);

        rewind(10);
        assertEq(block.timestamp, startAt + 100 - 10);
    }
}

//     function setUp() public {
//         auction = new Auction();
//         startAt = block.timestamp;
//     }

//     function testBidFailBeforeStartTime() public {
//         vm.expectRevert(bytes("cannot bid"));
//         auction.bid();
//     }

//     function testBid() public {
//         vm.warp(startAt + 1 days);
//         auction.bid();
//     }

//     function testBidFailsAfterEndTime() public {
//         vm.expectRevert(bytes("cannot bid"));
//         vm.warp(startAt + 2 days);
//         auction.bid();
//     }

//     function testTimestamp() public {
//         uint256 t = block.timestamp;

//         // skip - increment current timestamp
//         skip(100);
//         assertEq(block.timestamp, t + 100);

//         // rewind - decrement current timestamp
//         rewind(10);
//         assertEq(block.timestamp, t + 100 - 10);
//     }

//     function testBlockNumber() public {
//         // vm.roll = set block.number
//         uint256 b = block.number;
//         vm.roll(999);
//         assertEq(block.number, 999);
//     }
// }
