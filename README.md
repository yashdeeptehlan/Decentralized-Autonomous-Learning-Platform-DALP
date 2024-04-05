# Decentralized-Autonomous-Learning-Platform-DALP
The Decentralized Autonomous Learning Platform (DALP) is a blockchain-based platform designed to facilitate decentralized learning experiences. It leverages blockchain technology to provide transparency, immutability, and interoperability for educational content and transactions.

## Features

1. Course Management: Create, transfer, and access courses as unique digital assets.
2. Ownership Transfer: Transfer ownership of courses securely using blockchain transactions.
3. Provenance Tracking: Track the history of course ownership and transactions.
4. Royalties Distribution: Distribute royalties to course creators based on predefined criteria.
5. Rewards Distribution: Reward participants upon course completion.
6. Validation System: Validate tasks and distribute rewards to validators.
7. Access Control: Manage access to courses and content using role-based access control.

## Smart Contracts

The platform consists of several smart contracts written in Solidity:

1. Course Contract (ERC721): Manages courses as non-fungible tokens (NFTs), including creation, transfer, and access.
2. Ownership Contract: Facilitates ownership transfer of courses.
3. Provenance Contract: Tracks the history of course ownership and transactions.
4. Royalties Contract: Handles distribution of royalties to course creators.
5. Rewards Contract: Manages distribution of rewards to participants upon course completion.
6. Validation Contract: Validates tasks and distributes rewards to validators.
7. Access Contract: Manages access control to courses and content.

## Prerequisites

Before getting started, ensure you have the following installed on your machine:

1. Node.js and npm (or yarn)
2. Truffle framework
3. Sepolia testnet using Infura for smart contract deployment 
4. Pinata for IPFS
5. Metamask Wallet with sepolia ETH

## Installation

1. Install dependencies:
```
npm install
```

## Usage

Compile the smart contracts using Truffle:
```
truffle compile
```

Deploy the smart contracts to a blockchain network:
```
truffle migrate --network sepolia
```

You can interact with the deployed smart contracts using Truffle console or scripts:
```
truffle console
```

## License

This project is licensed under the MIT License.
