// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./AccessControl.sol";

contract Provenance {
    // Struct to represent the history of a course
    struct CourseHistory {
        address creator; // Address of the entity who created the course
        uint256 timestamp; // Timestamp when the event occurred
        string eventType; // Type of event (e.g., "Creation", "Transfer")
    }

    // Mapping to store the history of each course
    mapping(uint256 => CourseHistory[]) private courseHistory;

    // Instance of the AccessControl contract for permission management
    AccessControl private accessControlContract;

    // Event emitted when a course event is recorded
    event CourseEventRecorded(uint256 indexed courseId, address indexed actor, string eventType, uint256 timestamp);

    // Constructor to initialize the contract with the address of the AccessControl contract
    constructor(address _accessControlAddress) {
        accessControlContract = AccessControl(_accessControlAddress);
    }

    // Function to record the creation of a course
    function recordCreation(uint256 courseId, address creator) external {
        // Ensure that the caller has the necessary role to record a course creation event
        require(accessControlContract.hasRole(accessControlContract.CREATOR_ROLE(), msg.sender), "Caller is not authorized");

        // Push the course creation event to the history array
        courseHistory[courseId].push(CourseHistory(creator, block.timestamp, "Creation"));

        // Emit the course creation event
        emit CourseEventRecorded(courseId, creator, "Creation", block.timestamp);
    }

    // Function to record the transfer of ownership of a course
    function recordTransfer(uint256 courseId, address from, address to) external {
        // Ensure that the caller has the necessary role to record a course transfer event
        require(accessControlContract.hasRole(accessControlContract.CREATOR_ROLE(), msg.sender), "Caller is not authorized");

        // Push the course transfer event to the history array
        courseHistory[courseId].push(CourseHistory(to, block.timestamp, "Transfer"));

        // Emit the course transfer event
        emit CourseEventRecorded(courseId, to, "Transfer", block.timestamp);
    }

    // Function to retrieve the history of a course
    function getCourseHistory(uint256 courseId) external view returns (CourseHistory[] memory) {
        return courseHistory[courseId];
    }
}
