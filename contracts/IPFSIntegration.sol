// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./CustomAccessControl.sol";
import "node_modules/ipfs-http-client";

contract IPFSIntegration {
    CustomAccessControl private accessControlContract;
    bytes32 private ipfsHash;

    // IPFS client instance
    IPFS.Client private ipfs;

    // Event emitted when content is uploaded to IPFS
    event ContentUploaded(bytes32 indexed ipfsHash);

    // Event emitted when content is retrieved from IPFS
    event ContentRetrieved(bytes32 indexed ipfsHash);

    constructor(address _accessControlAddress) {
        accessControlContract = AccessControl(_accessControlAddress);
        ipfs = IPFS.Client("https://coffee-effective-nightingale-463.mypinata.cloud/ipfs/QmTiHgmUA9bDjb1oRZeVJZz4hzJnuoPNPUVcMWRyt8gR4h"); // Initialize IPFS client
    }

    // Function to upload content to IPFS
    function uploadContent(string memory content) public {
        require(accessControlContract.hasRole(accessControlContract.ADMIN_ROLE(), msg.sender), "Caller is not authorized");

        bytes memory contentBytes = bytes(content);
        ipfsHash = ipfs.add(contentBytes); // Upload content to IPFS
        emit ContentUploaded(ipfsHash);
    }

    // Function to retrieve content from IPFS
    function retrieveContent() public view returns (string memory) {
        require(accessControlContract.hasRole(accessControlContract.ADMIN_ROLE(), msg.sender), "Caller is not authorized");

        bytes memory retrievedBytes = ipfs.cat(ipfsHash); // Retrieve content from IPFS
        string memory content = string(retrievedBytes);
        emit ContentRetrieved(ipfsHash);
        return content;
    }
}
