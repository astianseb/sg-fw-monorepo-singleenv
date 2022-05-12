#!/bin/sh
cd ../env
terraform destroy -var-file=./variables/common.tfvars -var-file=./variables/dev.tfvars