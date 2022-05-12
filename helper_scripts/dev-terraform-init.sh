#!/bin/sh
cd ../env
echo "Test"
pwd
terraform init -backend-config=./variables/dev.tfbackend -reconfigure