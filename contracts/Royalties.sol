// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./AccessControl.sol";

contract Royalties {
    AccessControl private accessControlContract;

    // Mapping to store the royalty percentage for each course creator
    mapping(address => uint256) public royaltyPercentages;

    // Event emitted when royalties are distributed
    event RoyaltiesDistributed(address indexed courseCreator, uint256 amount);

    // Constructor function
    constructor(address _accessControlAddress) {
        accessControlContract = AccessControl(_accessControlAddress);
    }

    // Function to set the royalty percentage for a course creator
    function setRoyaltyPercentage(address courseCreator, uint256 percentage) external {
        require(accessControlContract.isCourseCreator(msg.sender), "Caller is not authorized to set royalties");
        require(percentage <= 100, "Royalty percentage must be less than or equal to 100");
        royaltyPercentages[courseCreator] = percentage;
    }

    // Function to calculate royalties for a course sale
    function calculateRoyalties(uint256 courseId, uint256 salePrice) internal view returns (uint256) {
        require(courseId < accessControlContract.getCourseCount(), "Course does not exist");
        uint256 percentage = royaltyPercentages[accessControlContract.getCourseCreator(courseId)];
        return (salePrice * percentage) / 100;
    }

    // Function to distribute royalties to the course creator
    function distributeRoyalties(uint256 courseId, uint256 salePrice) internal {
        address courseCreator = accessControlContract.getCourseCreator(courseId);
        uint256 royalties = calculateRoyalties(courseId, salePrice);
        payable(courseCreator).transfer(royalties);
        emit RoyaltiesDistributed(courseCreator, royalties);
    }
}
