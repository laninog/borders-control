'use strict';

let log4js = require('log4js');
let logger = log4js.getLogger('Helper');
logger.setLevel('DEBUG');

let path = require('path');
let util = require('util');
let fabricCaClient = require('fabric-ca-client');

let fabricClient = require('fabric-client');

fabricClient.setLogger(logger);

let ORGS = fabricClient.getConfigSetting('network-config');

let clients = {};
let channels = {};
let caClients = {};

let sleep = async function (sleep_time_ms) {
	return new Promise(resolve => setTimeout(resolve, sleep_time_ms));
}

async function getClientForOrg (org, username) {
	let client = fabricClient.loadFromConfig(fabricClient.getConfigSetting('network-connection-profile-path'));
	client.loadFromConfig(fabricClient.getConfigSetting('Goverment-connection-profile-path'));
	await client.initCredentialStores();

	if(username) {
		let user = await client.getUserContext(username, true);
		if(!user) {
			throw new Error(util.format('User was not found :', username));
		} else {
			logger.debug('User %s was found to be registered and enrolled', username);
		}
	}

	return client;
}

let getRegisteredUser = async function(username, userOrg, isJson, password) {
	try {
		let client = await getClientForOrg();
		logger.debug('Successfully initialized the credential stores');
			// client can now act as an agent for organization Org
			// first check to see if the user is already enrolled
		let user = await client.getUserContext(username, true);
		if (user && user.isEnrolled()) {
			logger.info('Successfully loaded member from persistence');
		} else {
			// user was not enrolled, so we will need an admin user object to register
			logger.info('User %s was not enrolled, so we will need an admin user object to register',username);
			let admins = fabricClient.getConfigSetting('admins');
			// let adminUserObj = await client.setUserContext({username: username, password: password});
      let adminUserObj = await client.setUserContext({username: username, password: password});
			let caClient = client.getCertificateAuthority();

			/*let secret = await caClient.register({
				enrollmentID: username,
				role: 'user',
				affiliation: userOrg.toLowerCase() + '.department1'
			},  adminUserObj);*/

			logger.debug('Successfully got the secret for user %s', username);
			// user = await client.setUserContext({username:username, password:secret});
      user = await client.setUserContext({username:username, password:'admin'});
			logger.debug('Successfully enrolled username %s  and setUserContext on the client object', username);
		}
		if(user && user.isEnrolled) {
			if (isJson && isJson === true) {
				let response = {
					success: true,
					message: username + ' enrolled Successfully',
				};
				return response;
			}
		} else {
			throw new Error('User was not enrolled ');
		}
	} catch(error) {
		logger.error('Failed to get registered user: %s with error: %s', username, error.toString());
		return 'failed '+error.toString();
	}

};

let setupChaincodeDeploy = function() {
	process.env.GOPATH = path.join(__dirname, fabricClient.getConfigSetting('CC_SRC_PATH'));
};

let getLogger = function(moduleName) {
	let logger = log4js.getLogger(moduleName);
	logger.setLevel('DEBUG');
	return logger;
};

exports.getClientForOrg = getClientForOrg;
exports.getLogger = getLogger;
exports.setupChaincodeDeploy = setupChaincodeDeploy;
exports.getRegisteredUser = getRegisteredUser;
