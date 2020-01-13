#!/bin/bash

./env.sh

./az-cli-login.sh
./tf-apply.sh
./deploy.sh
