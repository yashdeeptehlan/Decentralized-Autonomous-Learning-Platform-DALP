// SPDX-License-Identifier: MIT
// Course.sol

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./CustomAccessControl.sol";
import "./IPFSIntegration.sol";

contract Course is ERC721, Ownable {
    CustomAccessControl private accessControlContract;
    IPFSIntegration private ipfsIntegrationContract;

    // Struct to represent course metadata
    struct CourseMetadata {
        string name;
        string description;
        uint256 price; // Price in wei
        string ipfsHash; // IPFS hash for additional course content
    }

    // Array to store course metadata
    CourseMetadata[] public courses;

    // Event emitted when a new course is created
    event CourseCreated(uint256 indexed courseId, string name, string description, uint256 price, string ipfsHash);

    // Constructor function
    constructor(address _ipfsIntegrationAddress, address _accessControlAddress) ERC721("Course", "CRS") Ownable(msg.sender) {
        accessControlContract = AccessControl(_accessControlAddress);
        ipfsIntegrationContract = IPFSIntegration(_ipfsIntegrationAddress);
    }

    function getCourseCount() public view returns (uint256) {
        return courses.length;
    }

    // Function to create a new course
    function createCourse(string memory name, string memory description, uint256 price, string memory ipfsHash) public onlyOwner {
        uint256 courseId = courses.length;

        // Add course metadata to the array
        courses.push(CourseMetadata(name, description, price, ipfsHash));

        // Mint a new token representing the course
        _safeMint(owner(), courseId);

        // Emit event
        emit CourseCreated(courseId, name, description, price, ipfsHash);
    }

    // Function to purchase access to a course
    function purchaseAccess(uint256 courseId, address tokenAddress, uint256 fee) public payable {
        require(courseId < courses.length, "Course does not exist");

        CourseMetadata memory course = courses[courseId];
        require(msg.value >= course.price, "Insufficient funds");

        // Transfer ownership of the course token to the buyer
        _transfer(ownerOf(courseId), msg.sender, courseId);

        // Grant access to the course for the buyer
        accessControlContract.purchaseAccess(courseId, tokenAddress, fee);

        // Refund any excess payment
        if (msg.value > course.price) {
            payable(msg.sender).transfer(msg.value - course.price);
        }
    }

    // Function to transfer ownership of a course
    function transferCourse(uint256 courseId, address newOwner) public {
    // Ensure that the caller is the current owner of the course token
        require(ownerOf(courseId) == msg.sender, "You are not the owner of this course");

    // Transfer ownership of the course token to the new owner
        _transfer(msg.sender, newOwner, courseId);

    // Emit event
        emit Transfer(msg.sender, newOwner, courseId);
    }


    // Function to get course metadata by courseId
    function getCourse(uint256 courseId) public view returns (string memory name, string memory description, uint256 price, string memory ipfsHash) {
        require(courseId < courses.length, "Course does not exist");

        CourseMetadata memory course = courses[courseId];
        return (course.name, course.description, course.price, ipfsIntegrationContract.retrieveContent(course.ipfsHash));
    }
}
