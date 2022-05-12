#!/bin/bash
cd ../env
terraform plan -var-file=./variables/common.tfvars -var-file=./variables/dev.tfvars