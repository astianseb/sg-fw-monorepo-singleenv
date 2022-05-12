#!/bin/bash
cd ../env
terraform apply -var-file=./variables/common.tfvars -var-file=./variables/prod.tfvars