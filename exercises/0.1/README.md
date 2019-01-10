# Exercise #0.1: Launching a Cloud9 Environment

This is an exercise in which we will launch a Cloud9 IDE in your AWS account.

## Launch your Environment

1. Log into the Console
1. At the main screen, under "AWS services", click in the search bar and type "Cloud9".  Click on the result below
to go to the Cloud9 service portal.
1. Click on "Create Environment"
1. Give your environment a name and, optionally, a description.  Click Next
1. Accept all the default values on this screen and click "Next".
1. Review your settings and click "Create"
1. Wait for your environment to start.  In this step, AWS is provisioning an EC2 instance that 
your IDE environment will run on.  This gives us the distinct advantage of having a controlled 
environment for development regardless of client hardware and OS.  In the case of this workshop,
it also allows us to connect to our instances and AWS's API without worrying about port 
availability in a corporate office.  :-)
1. Once your IDE loads, you should see a Welcome document.  Your instructor will give you a 
walkthrough of the visible panel.  Feel free to take a moment to read through the welcome document.


## Configure your environment

1. Below the Welcome Document, you should see a terminal panel.
1. Expand the terminal panel up by clicking on the square icon at the upper right margin of the terminal panel (not the X).
1. This is a fully functioning bash terminal running inside an EC2 instance, but it is bare and doesn't have the things
we need to execute this workshop, so lets install a few packages.

```bash
sudo yum -y install jq git
sudo pip install --upgrade pip
sudo ln -s /usr/local/bin/pip /bin
sudo pip install --upgrade awscli
```

## Install Terraform

Run these commands in your cloud9 IDE terminal window to instal Terraform

```bash
curl -O https://releases.hashicorp.com/terraform/0.11.11/terraform_0.11.11_linux_amd64.zip
sudo unzip terraform_0.11.11_linux_amd64.zip -d /usr/bin/
```

Then test to ensure it was installed properly.

```bash
terraform -v
```

If you get an error, inform your instructor.

## Pull your resources repository

The next thing we need to do is pull this repository down so we can use it in future modules.  Run the following to 
do this:

```bash
mkdir -p workshop
cd workshop
git clone https://github.com/nubbthedestroyer/terraform-workshop .

```

Having done that, you should be ready for the next module.