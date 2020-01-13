#!/bin/bash

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


echo "$API_JPL_URL"
echo "$JPL_IMAGE_NAME"

cd battery-calcultator-front && docker-compose build && docker tag $JPL_IMAGE_NAME "$image_path" && docker push "$image_path" && cd ..

rm -rf battery-calcultator-front
docker rmi "$image_path"

echo "api url: $API_JPL_URL"

unset API_JPL_URL
unset JPL_IMAGE_NAME