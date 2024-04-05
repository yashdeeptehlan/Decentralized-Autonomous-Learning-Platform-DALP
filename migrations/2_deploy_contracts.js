const Course = artifacts.require("Course");
const AccessControl = artifacts.require("AccessControl");

module.exports = function (deployer, network, accounts) {
  deployer.deploy(AccessControl).then(() => {
    return deployer.deploy(Course, AccessControl.address);
  });
};
