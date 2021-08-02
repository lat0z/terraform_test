# terraform_test
# TEST #1
*  Create Terraform code to create an S3 bucket and an EC2 instance. Both resources must be tagged with Name=Flugel, Owner=InfraTeam.
*  Using Terratest, create the test automation for the Terraform code, validating that both resources are tagged properly.
*  Setup Github Actions to run a pipeline to validate this code.
*  Publish your code in a public GitHub repository, and share a Pull Request with your code. Do not merge into master until the PR is approved.
*  Include documentation describing the steps to run and test the automation.

To implement this test I have created the terraform folder which only contains the main.tf deployment file with the description of the required S3 and EC2 resources, I have tryed to reduce as much as possible hardcoded ids like the ami_id and the tags definition inside each resource, instead it is using a variable, so if there is a need to add or change current tags there is a single place to do that. 

To test the actual terraform deployment there is the terratest folder with the terraform_test.go file, which is using terratest to:
*  Initialize terraform.
*  Apply the configuration.
*  Read the output. 
*  Test the output comparing it with the expected tags.
*  Destroy the deployed resources.

To manually run the test, at repo root level just: 
> go test -v ./terratest/ 