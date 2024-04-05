// SPDX-License-Identifier: MIT

// AccessControl.sol

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract AccessControl {
    // Mapping to track access status for each user and course
    mapping(address => mapping(uint256 => bool)) public accessStatus;

    // Event emitted when a user purchases access to a course
    event AccessPurchased(address indexed user, uint256 indexed courseId);

    // Function to purchase access to a course
    function purchaseAccess(uint256 courseId, address tokenAddress, uint256 fee) public {
        // Transfer fee amount of tokens from user to this contract
        require(IERC20(tokenAddress).transferFrom(msg.sender, address(this), fee), "Token transfer failed");

        // Grant access to the course for the user
        accessStatus[msg.sender][courseId] = true;

        // Emit event
        emit AccessPurchased(msg.sender, courseId);
    }

    // Function to check access status for a course
    function getAccessStatus(address user, uint256 courseId) public view returns (bool) {
        return accessStatus[user][courseId];
    }
}
