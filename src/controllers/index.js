const login = require('../controllers/login');
const cidrToMask = require('../controllers/cidr-to-mask');
const maskToCidr = require('../controllers/mask-to-cdr');


const health = (req) => {
    return "Hello world"
}

module.exports = {
	cidrToMask,
	login,
	maskToCidr,
	health,
}
