#!/bin/bash
cd ../env
terraform init -backend-config=./variables/prod.tfbackend -reconfigure