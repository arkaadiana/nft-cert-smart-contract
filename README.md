# Certificate NFT Smart Contract

## Overview

This project implements a **Certificate NFT Smart Contract** using **Solidity** and **Foundry**. It allows the contract owner to mint NFTs representing digital certificates, preventing unauthorized transfers or approvals.

## Features
- **ERC721-based Soulbound Certificate NFTs**
- **OnlyOwner Minting**: Only the contract owner can mint new certificates.
- **Soulbound Mechanism**: NFTs cannot be transferred, ensuring authenticity.
- **Metadata Storage**: Stores metadata in a Base64-encoded JSON format.
- **Test Suite**: Includes tests for minting and security constraints using Foundry.

## Dependencies
This project uses OpenZeppelin libraries and Foundry for development. Ensure you have:
- **Foundry** installed ([Installation Guide](https://book.getfoundry.sh/getting-started/installation.html))
- **Solidity 0.8.13** or higher

## Installation
```sh
# Install Foundry
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

## Usage

### Build
```sh
forge build
```

### Run Tests
```sh
forge test
```

### Format Code
```sh
forge fmt
```

### Gas Snapshots
```sh
forge snapshot
```

### Local Blockchain Node
```sh
anvil
```

### Deployment & Execution

After setting up environment variables in `.env`, use the following commands to execute various operations:

```sh
# Build the smart contract
forge build

# Run tests
forge test

# Load environment variables
source .env

# Deploy contract
forge create --rpc-url $RPC_URL --private-key $PRIVATE_KEY src/CertificateNFT.sol:CertificateNFT \
  --gas-limit 10000000 --gas-price 1000000000 --broadcast --verify \
  --verifier blockscout --verifier-url https://niskala.mandalachain.io/api \
  --optimize --optimizer-runs 200

# Run minting script
forge script --rpc-url $RPC_URL --private-key $PRIVATE_KEY script/MintingNFTScript.sol:MintingNFTScript --broadcast
```

## Contract Details
### `CertificateNFT.sol`
The `CertificateNFT` contract:
- Uses **ERC721URIStorage** for storing metadata.
- Implements **Ownable** to restrict minting access.
- Implements **Soulbound Mechanism** by overriding `transferFrom`, `approve`, and `setApprovalForAll` to disable transfers.
- Generates Base64-encoded metadata dynamically.

### `MintingNFTScript.sol`
- This script allows the contract owner to mint new NFTs using Foundry scripts.
- Calls the `mintingNFT` function from `CertificateNFT.sol`.

## Running Tests
```sh
forge test
```
### Test Cases:
- **Minting NFT** (`testMintNFT`) ensures the owner can successfully mint an NFT.
- **Soulbound Restriction** (`testCannotTransfer`) verifies that NFTs cannot be transferred.
- **Approval Restrictions** (`testCannotApprove`, `testCannotSetApprovalForAll`) confirm that approvals are blocked.

## License
This project is licensed under the **[MIT License](LICENSE)**.

