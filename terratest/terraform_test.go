package test 

import (
  "testing"
	"reflect"
	"github.com/stretchr/testify/assert"
  "github.com/gruntwork-io/terratest/modules/terraform"
)

func TestTerraformEx1(t *testing.T) {
    terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
    	TerraformDir: "../terraform",
  })

  //Clean up resources executing "Terraform destroy" at the end of the test.
  defer terraform.Destroy(t, terraformOptions)

	//Run "terraform init" and "terraform apply", Fail the test if there are any errors.
	terraform.InitAndApply(t, terraformOptions)

	//Setup a map with the expected tags to test current terraform deployment 
	want := make(map[string]string)
	want["Name"] ="Flugel"
	want["Owner"]="DevTeam" //"InfraTeam"

	//Run terraform outputMap to retrieve the tags map from the EC2 instance (instance_tags) and the S3 bucket (bucket_tags)
	instance_output :=terraform.OutputMap(t, terraformOptions, "instance_tags")
	bucket_output   :=terraform.OutputMap(t, terraformOptions, "bucket_tags")

	//Compare the maps, using reflect.DeepEqual which will return True if both are the same, that is why the assert.True
	//if the maps are not the same there will be a test error. 
	assert.True(t, reflect.DeepEqual(instance_output,want))
	assert.True(t, reflect.DeepEqual(bucket_output,want))
}
