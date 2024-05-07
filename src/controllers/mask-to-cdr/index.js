const { validateQueryParam } = require('../../common');
const { calculateCidr } = require('./auxiliaries');

const maskToCidr = (queryParams) => {
    try {
        const netmask = validateQueryParam('value', queryParams);
        if (netmask)
	        return calculateCidr(netmask);
        return null;
    } catch (error) {
        console.error(`error converting mask with error: `, error);
        return null; 
    }
}

module.exports = maskToCidr;