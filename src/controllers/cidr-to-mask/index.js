const { validateQueryParam } = require('../../common');
const { createNetmask } = require('./auxiliaries');

const cidrToMask = (queryParams) => {
    try {
        const bit = validateQueryParam('value', queryParams);
        if (bit) 
	        return createNetmask(bit);
        return null;
    } catch (error) {
        console.error(`error converting cidr with error: `, error);
        return null; 
    }
}

module.exports = cidrToMask;