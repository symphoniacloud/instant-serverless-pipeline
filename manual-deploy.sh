#!/bin/bash

usage="Usage: manual-deploy.sh -b BUCKET"

while [[ $# -gt 1 ]]
do
KEY="$1"

case $KEY in
    -b|--bucket)
    BUCKET="$2"
    shift # past argument
    ;;
    *)
            # unknown option
    ;;
esac
shift # past argument or value
done

if [[ -z "$BUCKET" ]]; then
    echo "BUCKET not set"
    echo "$usage"
    exit 1
fi

set -eu

npm install
npm run test
npm run dist
aws cloudformation package --template-file sam.yml --s3-bucket $BUCKET --s3-prefix "instant-manual-serverless-app" --output-template-file packaged-template.yaml
aws cloudformation deploy --template-file packaged-template.yaml --stack-name instant-manual-serverless-app --capabilities CAPABILITY_IAM