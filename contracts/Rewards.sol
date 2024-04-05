// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./AccessControl.sol";

contract Rewards {
    AccessControl private accessControlContract;

    // Event emitted when rewards are distributed
    event RewardsDistributed(uint256 indexed courseId, address indexed participant, uint256 amount);

    constructor(address _accessControlAddress) {
        accessControlContract = AccessControl(_accessControlAddress);
    }

    // Function to calculate rewards for a participant upon course completion
    function calculateRewards(uint256 courseId, address participant) external view returns (uint256) {
        // Placeholder logic: Reward amount is fixed for demonstration purposes
        uint256 rewardAmount = 100; // Assuming the reward amount is 100 wei
        return rewardAmount;
    }

    // Function to distribute rewards to a participant
    function distributeRewards(uint256 courseId, address participant) external {
        // Ensure that only authorized entities can call this function
        require(accessControlContract.hasRole(accessControlContract.ADMIN_ROLE(), msg.sender), "Caller is not authorized");

        // Calculate rewards for the participant
        uint256 rewardsAmount = calculateRewards(courseId, participant);

        // Transfer rewards to the participant
        payable(participant).transfer(rewardsAmount);

        // Emit an event after distributing rewards
        emit RewardsDistributed(courseId, participant, rewardsAmount);
    }
}
