#!/bin/bash

set -eu

aws cloudformation create-stack \
        --capabilities CAPABILITY_IAM \
        --stack-name instant-serverless-pipeline \
        --parameters ParameterKey=ApplicationStackName,ParameterValue=instant-serverless-app \
        --template-body file://s3-source-pipeline.yml
