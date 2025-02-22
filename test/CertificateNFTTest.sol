// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {CertificateNFT} from "../src/CertificateNFT.sol";
import {Vm} from "forge-std/Vm.sol";

contract CertificateNFTTest is Test {
    CertificateNFT public certificateNFT;
    address public owner = address(this);
    address public user1 = address(1);
    address public user2 = address(2);

    function setUp() public {
        certificateNFT = new CertificateNFT();
    }

    function testMintNFT() public {
        string memory base64Image = "dummyBase64Image";
        vm.prank(owner);
        certificateNFT.mintingNFT(base64Image);

        assertEq(certificateNFT.ownerOf(1), owner);
    }

    function testCannotTransfer() public {
        string memory base64Image = "dummyBase64Image";
        vm.prank(owner);
        certificateNFT.mintingNFT(base64Image);

        vm.expectRevert(CertificateNFT.TransferNotAllowed.selector);
        vm.prank(owner);
        certificateNFT.transferFrom(owner, user1, 1);
    }

    function testCannotApprove() public {
        string memory base64Image = "dummyBase64Image";
        vm.prank(owner);
        certificateNFT.mintingNFT(base64Image);

        vm.expectRevert(CertificateNFT.ApprovalNotAllowed.selector);
        vm.prank(owner);
        certificateNFT.approve(user1, 1);
    }

    function testCannotSetApprovalForAll() public {
        vm.expectRevert(CertificateNFT.ApprovalForAllNotAllowed.selector);
        vm.prank(owner);
        certificateNFT.setApprovalForAll(user1, true);
    }
}
