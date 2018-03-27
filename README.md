# instant-serverless-pipeline
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

This small project gets you started with all of the above, for a Serverless app, so that you can start concentrating on your code, as follows:

* For Source Control we stub with S3 for a simple flow, but also provide a Github hook
* For code we give a starter lambda function in `lib\index.js`. This function makes a call to a remote resource, and returns a value based on that call.
* An example unit test is included at `test\indexTest.js`
* Dependency management is provided by NPM in `package.json`
* For build, also use the NPM script. See the tasks in the `manual-deploy.sh` file
* Packaging is a matter of simple zipping, defined in the build script.
* Deployment is via the Serverless Application Model (SAM) and CloudFormation, as defined in the `sam.yml` file
* Continuous Integration is supplied by CodePipeline, defined in the `s3-source-pipeline.yml` file or *TODO-Github-version*, triggered by an update to S3 or Github
* Automated Deployment is also supplied by CodePipeline, integrated with SAM

# Using the skeleton

In your local environment make sure you have the AWS CLI setup, with a user with enough privileges to create CloudFormation stacks.

## Using S3 as 'source control'

1. Clone this repo, and run `create-s3-source-pipeline.sh` .
2. Find the `instant-serverless-pipeline` stack in CloudFormation and wait for it to complete.
3. Run `commit-code-s3.sh`
4. Find your pipeline in CodePipeline, and wait for it to complete
5. Run `pipeline-test.sh` to verify your application
6. Start programming!




