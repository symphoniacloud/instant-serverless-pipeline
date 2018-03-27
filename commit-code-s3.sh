#!/bin/bash

set -eu

rm -rf source-dist
mkdir source-dist
zip -r source-dist/source lib test package.json sam.yml buildspec.yml

SOURCE_S3=$(aws cloudformation list-exports --query 'Exports[?Name==`InstantServerlessPipelineSourceBucket`].Value' --output text)
echo "Source S3 bucket is $SOURCE_S3"

aws s3 cp source-dist/source.zip $SOURCE_S3