# main.tf

# Declare the provider being used, in this case it's AWS.

provider "aws" {
  region = "${var.region}"
}

provider "aws" {
  alias = "west"
  region = "${var.region2}"
}

# declare a resource stanza so we can create something.
resource "aws_s3_bucket" "user_bucket" {
  bucket_prefix = "${var.student_name}"
  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket" "user_bucket2" {
  provider = "aws.west"
  bucket_prefix = "${var.student_name}"
  versioning {
    enabled = true
  }
}


