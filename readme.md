# Cloud Resume API Challenge
This repo contains IaC both SAM and Terraform to provision and set up the cloud resume API challenge both on your local machine and on AWS respoectively.

![Case Study](./img/cch1.png)

A link to the case study and architecture: https://medium.com/@aesheriff30/cloud-resume-api-challenge-aws-phase-1-architecting-and-planning-5957ad21617e

## Running on Local

![Case Study](./img/cch2.png)

In `/lambda-local` folder contains SAM template and lambda code and also docker-compose to spin up a dynamodb container. A very detailed guide is given: https://medium.com/@aesheriff30/cloud-resume-api-challenge-aws-phase-2-local-development-for-serverless-applications-e3277004700c

But on a high level to spin it up, navigate to the directory (Ensure you have docker ans SAM cli installed)

```
cd lambda-local
```

spin up dynamodb using docker compose

```
docker-compose up
```

Build SAM template

```
sam build
```

Start the SAM local API

```
sam local start-api --docker-network lambda-local_serverless 
```

## Running on AWS

![Case Study](./img/cch3.png)

To spin up the infra on AWS, ensure you have your AWS credentials (Access Keys and Secret Access Key) configured on your machine. A detailed guide is given: https://medium.com/@aesheriff30/cloud-resume-api-challenge-aws-phase-3-moving-to-the-cloud-cecbd649b90f

But on a high level to spin it up, execute the commands (Ensure you have terraform installed)

Navigate to the terraform directory

```
cd terraform-infra
```

Initialize terraform

```
terraform init
```

Validate the terraform config
```
terraform validate
```

Apply the configuration

```
terraform apply --auto-approve
```

## Using the GitHub Actions Pipeline

The repo also contains a github actions pipeline script which is explained in detail in this article: https://medium.com/@aesheriff30/cloud-resume-api-challenge-aws-phase-4-devops-practices-d9acd20f0bd6

But on a high level, to use the pipeline, ensure that you set the repository secrets for `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`. The values should be your AWS access keys to authenticate to AWS.

Also make sure you set the state bucket name to your s3 bucket name. See `/terraform-infra/backend.tf` to edit the bucket name.

To trigger the pipeline the provisions resources, you can push some changes to the repo and the pipeline will be automatically triggered. ALternatively, you can simply trigger the pipeline from github actions UI using the workflow dispatch.

Check the terraform apply step for the api invoke url as outputs.

### To Destroy

To clean up resources created, there's a pipeline you can trigger manually. Ensure you select "yes" lto destroy aws resources completely.

# Accessing the API

Ensure you access the api on the invoke url route /resume-data for example: https://vkmm0lx8g3.execute-api.us-east-1.amazonaws.com/dev/resume-data



