#!/bin/bash

export TF_VAR_tenant_id=
export TF_VAR_subscription_id=
export TF_VAR_client_id=
export TF_VAR_client_secret=

if [ ! -d ./.terraform ]; then
    ./terraform init -input=false ./terraform_scripts
    echo "terraform initialized"
fi

az login --service-principal --username="$TF_VAR_client_id" --password="$TF_VAR_client_secret" --tenant="$TF_VAR_tenant_id"
echo "connected to az cli"

echo "creating ressources"
./terraform apply -input=false ./terraform_scripts
echo "ressources created"

back=https://github.com/jpl-terraform/api.git
function=https://github.com/Shengael/esgi-jpl-function.git
front=https://github.com/Shinzukyo/battery-calcultator-front.git
image_name=battery-front

az webapp deployment source config --name "$(./terraform output api_service_name)" \
    --resource-group "$(./terraform output api_group_name)" \
    --repo-url $back --branch master --manual-integration

az functionapp deployment source config \
    --name "$(./terraform output function_name)" \
    --resource-group "$(./terraform output func_group_name)" \
    --repo-url $function \
    --branch master --manual-integration

az acr login --name "$(./terraform output registry_name)"

git clone $front

API_JPL_URL="$(./terraform output api_url)"
image_path="$(./terraform output registry_target)"

export API_JPL_URL
export JPL_IMAGE_NAME=$image_name

cd battery-calcultator-front && docker-compose build && docker tag $JPL_IMAGE_NAME "$image_path" && docker push "$image_path" && cd ..

rm -rf battery-calcultator-front
docker rmi "$image_path"

echo "api url: $API_JPL_URL"

unset API_JPL_URL
unset JPL_IMAGE_NAME
