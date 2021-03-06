#!/bin/bash
 
if ! dpkg-query -W -f='${Status}' unzip | grep "ok installed"; then
    sudo apt install unzip
fi
 
if ! dpkg-query -W -f='${Status}' git | grep "ok installed"; then
    sudo apt install git
fi
 
 
git clone https://github.com/Shengael/terraform-implementation.git && cd terraform-implementation || return
 
curl https://releases.hashicorp.com/terraform/0.12.20/terraform_0.12.20_linux_amd64.zip -o dl.zip && unzip dl.zip

rm dl.zip
