#!/bin/bash

set -eu

lambdaName=$(aws cloudformation list-stack-resources --stack-name instant-serverless-app --query 'StackResourceSummaries[?LogicalResourceId==`InstantLambda`].PhysicalResourceId' --output text)
echo "Lambda in stack instant-serverless-app is $lambdaName"

aws lambda invoke --invocation-type RequestResponse --function-name $lambdaName --payload \"hello-from-cli\" outputfile.txt
cat outputfile.txt
echo