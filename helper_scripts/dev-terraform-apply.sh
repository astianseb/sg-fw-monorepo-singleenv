#!/bin/sh
cd ../env
terraform apply -auto-approve -var-file=./variables/common.tfvars -var-file=./variables/dev.tfvars