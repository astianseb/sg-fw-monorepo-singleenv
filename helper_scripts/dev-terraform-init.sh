#!/bin/bash
cd ../env
terraform init -backend-config=./variables/dev.tfbackend -reconfigure