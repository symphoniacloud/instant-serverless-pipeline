var assert = require('assert'),
    index = require('../lib/index.js');

describe('processCallToJsonTest', function () {
    it('should create useful message', function () {
        assert.equal("AWS Pricing Info Publication Date is 2018-03-27T18:09:52Z", index.processCallToJsonTest({ "publicationDate": "2018-03-27T18:09:52Z" }));
    });
});