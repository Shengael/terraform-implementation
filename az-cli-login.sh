#!/bin/bash
# shellcheck disable=SC2154
az login --service-principal --username="$TF_VAR_client_id" --password="$TF_VAR_client_secret" --tenant="$TF_VAR_tenant_id"