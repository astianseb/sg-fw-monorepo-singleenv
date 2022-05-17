#!/bin/sh
cd ../env
terraform apply -var-file=./variables/common.tfvars -var-file=./variables/dev.tfvars