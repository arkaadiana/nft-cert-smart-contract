// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {CertificateNFT} from "../src/CertificateNFT.sol";

contract MintingNFTScript is Script {

    function run() external {
        vm.startBroadcast();

        CertificateNFT certificateNFT = CertificateNFT(0x81B662970F297aAbEA4E9c280C2433957696e0A4);
        certificateNFT.mintingNFT("");

        vm.stopBroadcast();
    }
}
