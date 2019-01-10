# Exercise #2: Using Variables

For this exercise, we will be incorporating the variables concept to change the S3 bucket prefix 
from the instructors name to your name.  There are a few ways to accomplish this, try doing each 
one independently.  If you get stuck, refer to the terraform in the "solution" directory as a reference.

There are many schools of thought on how to use variables to configure reusable terraform, 
but we will be exploring the core mechanics so that you as a student will understand the underlying processes
that the various methods exploint

### Adding the variable stanza

In order to leverage the mechanics around the variable concept in terraform, you must declare each variable.

Try adding a variable stanza called student_name.  We are going to set the default to "student-", so that the 
variable has something to fall back on in case we forget to input something.  Add this stanza to the variables.tf 
file.  It should look like this:

```hcl
variable "student_name" {
  default = "student-"
  type = "string"
}
```

If the "default" parameter is left out of the stanza, then the variable becomes a required variable, which means
that terraform will not be able to execute if the variable's value is not supplied through one of the methods below.

### Adding the values statically in the variables stanza.

You might notice that there is no "value" parameter in the syntax for the variable object.  
This is because the variables stanzas are not meant to be inputs themselves, but rather placeholders
that handle input and allow for reference throughout the working directory.  Though it is true that
variables stanzas can be used this way by simply setting the "default" to the desired value, this 
negates the benefits of Terraform's native re-usability.  Instead, try using one of the below methods.

### tfvars file

In each terraform working directory, there can be a file named "terraform.tfvars" that contains HCL that defines 
values for variables for that working directory.  tfvar files can also be referenced via command line.  Let's try a 
few things.

* create a file called terraform.tfvars in this directory
* insert the following code into it:
```hcl
# swap "yourname" with your actual name or other identifying text
student_name = "yourname"
```
* then change the value in main.tf for the s3 bucket name from "mlucas-" to "${var.student_name}"
this is the a special syntax that terraform calls interpolation that allows for variable referencing, as 
well as other advanced features.
* then run this in the same directory
```bash
terraform plan
``` 

You should see that the terraform plan output includes an s3 bucket, and that the value for bucket_name 
utilizes your chosen identifying text.  If you have a different result, reference the tfvars folder under
the "solutions" folder for reference.

### Command Line Arguments

Another method you can use is to insert variables via the CLI.  This allows for quick variable substitution and 
testing because values entered via CLI override values from other methods.

* run the following in this working directory (if you were able to complete the previous), swapping for your
identifier like before.

```bash
terraform plan -var 'student_name=yourname'
```

* You can try using a different identifier to see if it worked.  Like before, you should 
be able to see the new identifier in the plan output.

### Using Environment variables

Environment variables can be used to set the value of an input variable in the root module. The name of the environment variable must be TF_VAR_ followed by the variable name, and the value is the value of the variable.

Try the following:

```bash
TF_VAR_student_name=yourname terraform plan 
```

This can be a useful method for secrets handling, or other automated use cases.

### Locals

A related concept that we will cover a little later is something called a local.  Locals act like variables, in that they
can be referenced from multiple locations, but locals can't take inputs like variables.  Locals also allow for 
interpolation, like merging strings or basing value on chained dependencies of locals.  Locals act more similiarly to
the standard variable you might be working with in Python, for example.  Here is an example:

```hcl
locals {
  title = "CEO"
  name = "${var.student_name}"
  name_and_title = "${local.name} - ${local.title}"
  
}
```

