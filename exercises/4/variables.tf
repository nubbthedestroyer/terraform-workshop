# variables.tf

# Declare a variable so we can use it.
variable "region" {
  default = "us-east-1"
}

variable "student_name" {
  default = "student-"
}


# The following configuration is used to grab a generated s3 bucket name from a separate terraform project under the
# "other_project" folder.  tfstate files are provided for you for simplicity.

data "terraform_remote_state" "local" {
  backend = "local"
  config {
    path = "other_project/terraform.tfstate"
  }
}

output "other_bucket" {
  value = "${data.terraform_remote_state.local.bucket_name}"
}