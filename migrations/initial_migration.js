const Migrations= artifacts.require('InitialMigration');

module.exports = function(deployer) {
    deployer.deploy(Migrations);
};