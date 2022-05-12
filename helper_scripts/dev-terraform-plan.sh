#!/bin/sh
cd ../env
echo "Test"
pwd
terraform plan -var-file=./variables/common.tfvars -var-file=./variables/dev.tfvars