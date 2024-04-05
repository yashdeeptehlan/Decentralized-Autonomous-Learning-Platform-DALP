// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract CustomAccessControl is AccessControl {
    // Roles for different types of users
    bytes32 public constant CREATOR_ROLE = keccak256("CREATOR_ROLE");
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");
    bytes32 public constant VALIDATOR_ROLE = keccak256("VALIDATOR_ROLE");

    // Mapping to track access status for each user and course
    mapping(uint256 => mapping(address => bool)) public accessStatus;

    // Event emitted when a user purchases access to a course
    event AccessPurchased(address indexed user, uint256 indexed courseId);

    constructor() {
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    // Function to grant access to a course for a user
    function grantAccess(uint256 courseId, address user) external onlyRole(ADMIN_ROLE) {
        accessStatus[courseId][user] = true;
    }

    // Function to revoke access to a course for a user
    function revokeAccess(uint256 courseId, address user) external onlyRole(ADMIN_ROLE) {
        accessStatus[courseId][user] = false;
    }

    // Function to purchase access to a course
    function purchaseAccess(uint256 courseId, address tokenAddress, uint256 fee) public {
        // Transfer fee amount of tokens from user to this contract
        require(IERC20(tokenAddress).transferFrom(msg.sender, address(this), fee), "Token transfer failed");

        // Grant access to the course for the user
        accessStatus[courseId][msg.sender] = true;

        // Emit event
        emit AccessPurchased(msg.sender, courseId);
    }

    // Function to check access status for a course
    function hasAccess(address user, uint256 courseId) public view returns (bool) {
        return accessStatus[courseId][user];
    }
}
