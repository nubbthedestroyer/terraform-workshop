# Exercise #6: Modules

Terraform is ALL about modules.  Every terraform working directory is potentially a module that could be reused by others
This is what made Terraform so massively popular.

In this exercise, we are going to modularize the code that we have been playing with during this whole workshop, but instead of
constantly redeclaring everything, we are just going to reference the module that we've created and see if it works.

First, create a main.tf file in the main directory for the 6th exercise.  Inside the main.tf file you created, please add the following:

```hcl
provider "aws" {
  region = "us-east-1"
}

module "s3_bucket1" {
  region = "us-east-1"
  source = "./modules/s3_bucket/"
}

module "s3_bucket2" {
  region = "us-west-2"
  source = "./modules/s3_bucket/"
}
```

What we've done here is create a tf config file that references a module stored in a
local directory, twice.  This allows us to encapsulate any complexity contained by the module's code
while still allowing us to pass variables into the module, which can then be handled and distributed
throughout the actualized.

After doing this, you can then begin the init and apply process.

```bash
terraform init
terraform plan
terraform apply
```

You'll notice that terraform manages each resource as if there is no module division, meaning the resources are bucketed
into one big change list, but under the covers Terraform's dependency graph will show some separation.  It's very difficult,
for example, to create dependencies between two resources that are in different modules.  You can, however, use
interpolation to create a variable dependency two two modules at the root level, ensuring one is created before the other.
Specific applications where direct resource dependency is required really necessitate the grouping of those resources
into a single module.
