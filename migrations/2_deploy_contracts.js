const LendingProtocol = artifacts.require("LendingProtocol");

module.exports = function (deployer) {
    deployer.deploy(LendingProtocol);
};