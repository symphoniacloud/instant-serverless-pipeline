# instant-serverless-pipeline

**This is still 'early access' - possibly a little bumpy still!**

Create a CodePipeline for a serverless app with one hand tied behind your back.

One of the chief benefits of Serverless apps is how quickly you can start a new application. That is, how long does it take to go from idea to production? And how long does it take to do that in a way that isn't a complete hack? We think you can do it very quickly. Without having to cut corners.

For a long time, we at Symphonia have believed that for any 'real' engineering project you have to start with some basic engineering building blocks:

* Source Control
* Code
* Tests
* Dependency management
* Build
* Packaging
* Deployment
* Continuous Integration
* Automated Deployment (Continuous Delivery)

This small project gets you started with all of the above on AWS, for a Serverless app, so that you can start concentrating on your code, as follows:

* For Source Control we stub with S3 for demo / training purposes, but will soon provide a Github version for more realistic workflows
* For code we give a starter lambda function in `lib\index.js`. This function makes a call to a remote resource, and returns a value based on that call.
* An example unit test is included at `test\indexTest.js`
* Dependency management is provided by NPM in `package.json`
* For build, also use the NPM script. See the tasks in the `manual-deploy.sh` file
* Packaging is a matter of simple zipping, defined in `package.json` .
* Deployment is via the [Serverless Application Model](https://github.com/awslabs/serverless-application-model) (SAM) and [CloudFormation](https://aws.amazon.com/cloudformation/), as defined in the `sam.yml` file
* Continuous Integration is supplied by [CodePipeline](https://aws.amazon.com/codepipeline/) and [CodeBuild](https://aws.amazon.com/codebuild/), defined in the `deployment-pipeline/s3-source-pipeline.yml` file or *TODO-Github-version*, triggered by an update to S3 or *TODO-Github*, and subsequent use of `deployment-pipeline/buildspec.yml`
* Automated Deployment is also supplied by CodePipeline, integrated with SAM

# Using the skeleton

In your local environment make sure you have the AWS CLI setup, with a user with enough privileges to create CloudFormation stacks.

## Using S3 as 'source control'

1. Clone this repo, change directory to `deployment-pipeline`, and run `create-s3-source-pipeline.sh` .
2. Find the `instant-serverless-pipeline` stack in CloudFormation and wait for it to be ready.
3. Change directory back to the project root and run `commit-code-s3.sh`
4. Find your pipeline in CodePipeline, and wait for it to start (triggered by S3, might take a minute) and complete.
5. Run `deployment-pipeline/pipeline-test.sh` to verify your application
6. Start programming!

## Deploying manually

If you want to deploy the application manually, without CodePipeline, use the `manual-deploy.sh` script, specifying an S3 bucket to use as your CloudFormation package store. You can verify the application by running `manual-test.sh` .

# Teardown

:warning: These steps must be completed in order, or resources might be stranded.

1. Delete the application stack:
    ```bash
    $ aws cloudformation delete-stack --stack-name instant-serverless-app
    ```

1. Find the physical resource IDs for the build pipeline's S3 buckets
    ```bash
    $ aws cloudformation list-stack-resources --stack-name instant-serverless-pipeline \
          --query 'StackResourceSummaries[?ResourceType==`AWS::S3::Bucket`].PhysicalResourceId' \
          --output text
    ```

1. Delete those buckets using the the S3 web console (https://console.aws.amazon.com/s3/home)

1. Delete the build pipeline stack:
    ```bash
    $ aws cloudformation delete-stack --stack-name instant-serverless-pipeline
    ```
# TODO

* Github version
* Tighten up privs in pipeline definition



