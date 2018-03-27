var request = require('request');

exports.handler = function(event, context, callback) {
  console.log("Starting event processing. This function doesn't use event input, but the value of the event is " + JSON.stringify(event));
  console.log("Calling AWS Pricing API");
  request("https://pricing.us-east-1.amazonaws.com/offers/v1.0/aws/index.json", function(err, res, body) {
    if (res && (res.statusCode === 200 || res.statusCode === 201)) {
      var friendlyMessage = exports.processCallToJsonTest(JSON.parse(res.body));
      console.log(friendlyMessage);
      callback(null, friendlyMessage);
    }
    else {
      console.log('Error: ' + err + ' ' + res + ' ' + body);
      callback('Error');
    }});
};

exports.processCallToJsonTest = function (pricingInfo) {
  return "AWS Pricing Info Publication Date is " + pricingInfo.publicationDate;
};