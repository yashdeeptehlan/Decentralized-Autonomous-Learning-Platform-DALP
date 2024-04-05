// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./AccessControl.sol";

contract Validation {
    AccessControl private accessControlContract;

    // Event emitted when a task is validated and rewards are distributed
    event TaskValidated(uint256 indexed taskId, address indexed validator, uint256 reward);

    constructor(address _accessControlAddress) {
        accessControlContract = AccessControl(_accessControlAddress);
    }

    // Function to validate a task and distribute rewards to the validator
    function validateTask(uint256 taskId, address validator) external {
        // Ensure that only authorized entities can call this function
        require(accessControlContract.hasRole(accessControlContract.ADMIN_ROLE(), msg.sender), "Caller is not authorized");

        // Placeholder logic: Reward amount is fixed for demonstration purposes
        uint256 reward = 50; // Assuming the reward amount is 50 wei

        // Transfer reward to the validator
        payable(validator).transfer(reward);

        // Emit an event after distributing the reward
        emit TaskValidated(taskId, validator, reward);
    }
}
