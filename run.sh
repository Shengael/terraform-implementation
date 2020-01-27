#!/bin/bash

export TF_VAR_tenant_id=0a75ec92-a05e-4a6f-ab2a-674c66a5e2ab
export TF_VAR_subscription_id=eb5221ea-7039-446e-b354-fbaf27f4583a
export TF_VAR_client_id=7e65e0c9-3866-41ad-84d2-cecde9376b8d
export TF_VAR_client_secret=e62be7a5-0b33-48fa-a350-1638fae04a91

if [ ! -d ./.terraform ]; then
    ./terraform init ./terraform_scripts
fi

az login --service-principal --username="$TF_VAR_client_id" --password="$TF_VAR_client_secret" --tenant="$TF_VAR_tenant_id"

./terraform apply ./terraform_scripts -y

back=https://github.com/Shinzukyo/battery-calculator-api.git
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
