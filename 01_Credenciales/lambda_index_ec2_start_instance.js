var AWS = require('aws-sdk');
exports.handler = function(event, context) {
    var ec2 = new AWS.EC2({region: 'us-east-1'});
    ec2.startInstances({InstanceIds : ['i-04e0b794b7ee3ae42', 'i-05252519c53960b5c', 'i-0515d42fdb39a70ec', 'i-054b2b78c76ceb43f', 'i-042a86f05a4973295'] },function (err, data) {
        if (err) console.log(err, err.stack); // an error occurred
        else console.log(data); // successful response
        context.done(err,data);
    });
};