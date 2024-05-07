const chai = require('chai');
const controller = require('../../../controllers/index');

const expect = chai.expect;

describe('cidr to mask function()', function () {
    const successfulResponse = { function: 'cidrToMask', input: '16', output: '255.255.0.0' };
    const queryParams = { value: '16' };
    it('Create mask', function () {
        const maskResponse = controller.cidrToMask(queryParams);
        expect(successfulResponse.output).to.be.equal(maskResponse.output);
    });
});