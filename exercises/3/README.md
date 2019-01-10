# Exercise #3: Plans and Applies

So now we are actually going to get into it and make some infrastructure happen.  For this exercise, we are going to:
1) run initial commands and setup our working directory
1) run an apply and understand the apply output and what it means,
1) and then go ahead and create an s3 bucket and a terraform apply.

### Initialization

Every time a new terraform working directory is created, we need to initialize it to prepare it to run against
the designated external API.  This does not need to happen after the first apply, just for new working directories.  
Before continuing, please ensure you are in the correct directory in the support resources.

```bash
terraform init
```

you should get an output similar to this:

```
Initializing provider plugins...
- Checking for available provider plugins on https://releases.hashicorp.com...
- Downloading plugin for provider "aws" (1.54.0)...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.aws: version = "~> 1.54"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

### Plan

Next step is to run a plan, which is a dry run that helps us understand what terraform intends to change when it 
runs the next apply.  Run the following:

```bash
terraform plan
```

Your output should look something like this:

```
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.


------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + aws_s3_bucket.user_bucket
      id:                          <computed>
      acceleration_status:         <computed>
      acl:                         "private"
      arn:                         <computed>
      bucket:                      <computed>
      bucket_domain_name:          <computed>
      bucket_prefix:               "yourname"
      bucket_regional_domain_name: <computed>
      force_destroy:               "false"
      hosted_zone_id:              <computed>
      region:                      <computed>
      request_payer:               <computed>
      versioning.#:                <computed>
      website_domain:              <computed>
      website_endpoint:            <computed>


Plan: 1 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.
```

From the above output, we can see that terraform will create a single S3 bucket.  An important line to note is the one
beginning with "Plan:".  We see that 1 resource will be created, 0 will be changed, and 0 destroyed.  Terraform is 
designed to detect when there is configuration drift in resources that it created and then intelligently determine
how to correct the difference.  This will be covered in a future exercise.

### Apply

Let's go ahead and let Terraform create the S3 bucket.

```bash
terraform apply
```

Terraform will execute another plan, and then ask you if you would like to apply the changes.  Type "yes" to approve, then
let it do its magic.  Your output should look like the following:

```
An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + aws_s3_bucket.user_bucket
      id:                          <computed>
      acceleration_status:         <computed>
      acl:                         "private"
      arn:                         <computed>
      bucket:                      <computed>
      bucket_domain_name:          <computed>
      bucket_prefix:               "yourname"
      bucket_regional_domain_name: <computed>
      force_destroy:               "false"
      hosted_zone_id:              <computed>
      region:                      <computed>
      request_payer:               <computed>
      versioning.#:                <computed>
      website_domain:              <computed>
      website_endpoint:            <computed>


Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_s3_bucket.user_bucket: Creating...
  acceleration_status:         "" => "<computed>"
  acl:                         "" => "private"
  arn:                         "" => "<computed>"
  bucket:                      "" => "<computed>"
  bucket_domain_name:          "" => "<computed>"
  bucket_prefix:               "" => "yourname"
  bucket_regional_domain_name: "" => "<computed>"
  force_destroy:               "" => "false"
  hosted_zone_id:              "" => "<computed>"
  region:                      "" => "<computed>"
  request_payer:               "" => "<computed>"
  versioning.#:                "" => "<computed>"
  website_domain:              "" => "<computed>"
  website_endpoint:            "" => "<computed>"
aws_s3_bucket.user_bucket: Creation complete after 3s (ID: yourname20190110050355702800000001)

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

Now lets run a plan again.

```bash
terraform plan
```

You should notice a couple differences:

* Terraform informs you that it is Refreshing the State.
    * after the first apply, any subsequent plans and applies will, by default, check the infrastructure it created and 
    updates the terraform state with any new information about the resource.
* Next, you'll notice that Terraform informed you that there are no changes to be made.  This is because the infrastructure 
was just just created and there were no changes.

### Handling Changes

Now, lets try making a change to the s3 bucket and allow Terraform to correct it.  Let's enable versioning on the bucket.

Find main.tf and modify the s3 bucket stanza to reflect the following:

```hcl
# declare a resource stanza so we can create something.
resource "aws_s3_bucket" "user_bucket" {
  bucket_prefix = "${var.student_name}"
  versioning {
    enabled = true
  }
}
```

Now run another apply:

```bash
terraform apply
```

You should see the following output, showing that the s3 bucket was updated to enable versioning.  Some resources
or some changes require that a resource be recreated to facilitate that change, and those cases are usually expected.
One example of this would be launch configurations.  In AWS, launch configurations cannot be changed, only copied 
and modified once during the creation of the copy.  Terraform is generally made aware of these caveats and 
handles those changes gracefully, including updating dependent resources to link to the newly created resource.  This
greatly simplifies complex or frequent changes to any size infrastructure and reduces the possibility of human error.

### Destroy

When infrastructure is retired, Terraform can destroy that infrastructure gracefully, ensuring that all resources
are removed and in the order that their dependencies require.  Let's destroy our s3 bucket.

```bash
terraform destroy
```

You should get the following:

```
aws_s3_bucket.user_bucket: Refreshing state... (ID: yourname20190110050355702800000001)

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  - aws_s3_bucket.user_bucket


Plan: 0 to add, 0 to change, 1 to destroy.

Do you really want to destroy?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

aws_s3_bucket.user_bucket: Destroying... (ID: yourname20190110050355702800000001)
aws_s3_bucket.user_bucket: Destruction complete after 0s

Destroy complete! Resources: 1 destroyed.
```

You'l notice that the destroy process if very similar to apply, just backwards.  :-)

