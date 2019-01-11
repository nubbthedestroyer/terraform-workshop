# Interacting with Providers

Providers are plugins that Terraform uses to understand various external APIs and cloud providers.  Thus far in this
workshop, we've used the AWS provider.  In this exercise we are going to create s3 buckets in multiple regions in a
single terraform working directory.  Running multiple providers in a single project is nifty but not always the recommended
approach.  For example, it may be more reasonable to use the remote_state features to access values in each module.

### Add the second provider

Add this variable stanza to the "variables.tf" file:

```hcl
variable "region2" {
  default = "us-west-2"
}
```

Then, add the new region to "main.tf" just under the existing provider block.

```hcl
provider "aws" {
  alias = "west"
  region = "${var.region2}"
}
```

Now, lets duplicate the s3 bucket and tell it to use the other provider.

next, just a Terraform apply and show.

```bash
terraform apply
terraform show
```
You've done this correctly if the output of the show command indicates that there are 2 s3 buckets and each is in a different region.