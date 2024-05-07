const chai = require('chai');
const controller = require('../../../controllers/index');

const expect = chai.expect;

describe('mask to cidr function()', function () {
    const successfulResponse = {
        "function": "maskToCidr",
        "input": "255.255.0.0",
        "output": 16
    };

    const queryParams = { value: '255.255.0.0' };

    it('Create Cidr', function () {
        const cidrResponse = controller.maskToCidr(queryParams);
        expect(successfulResponse.output).to.be.equal(cidrResponse.output);
    });
});