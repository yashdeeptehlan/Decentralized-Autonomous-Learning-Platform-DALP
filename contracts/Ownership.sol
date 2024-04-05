// SPDX-License-Identifier: MIT
// Ownership.sol

pragma solidity ^0.8.0;

import "./CourseV2.sol";

contract Ownership {
    Course private courseContract;

    // Constructor function
    constructor(address _courseAddress) {
        courseContract = Course(_courseAddress);
    }

    // Function to get the total number of courses
    function getCourseCount() public view returns (uint256) {
        return courseContract.getCourseCount();
    }

    // Function to transfer ownership of a course
    function transferOwnership(uint256 courseId, address newOwner) public {
        require(courseId < courseContract.getCourseCount(), "Course does not exist");

        require(msg.sender == courseContract.ownerOf(courseId), "You are not the owner of this course");

        // Transfer ownership of the course token to the new owner
        courseContract.transferFrom(msg.sender, newOwner, courseId);
    }

    // Function to get the owner of a course
    function getCourseOwner(uint256 courseId) public view returns (address) {
        require(courseId < courseContract.courses.length(), "Course does not exist");

        // Retrieve the owner of the course token
        return courseContract.ownerOf(courseId);
    }
}