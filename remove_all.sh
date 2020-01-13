#!/bin/bash

if [ $# = 0 ]; then
    echo "removal of the api group and its resources ..."
    az group delete --name "$(./terraform output api_group_name)" -y
    echo "removal of the func group and its resources ..."
    az group delete --name "$(./terraform output func_group_name)" -y
    echo "removal of the db group and its resources ..."
    az group delete --name "$(./terraform output db_group_name)" -y
    echo "removal of the bus group and its resources ..."
    az group delete --name "$(./terraform output bus_group_name)" -y
    echo "removal of the front group and its resources ..."
    az group delete --name "$(./terraform output front_group_name)" -y
fi

for arg in "$@"; do
    if [ "$arg" = "api" ]; then
        echo "removal of the api group and its resources ..."
        az group delete --name "$(./terraform output api_group_name)" -y
    elif [ "$arg" = "func" ]; then
        echo "removal of the func group and its resources ..."
        az group delete --name "$(./terraform output func_group_name)" -y
    elif [ "$arg" = "db" ]; then
        echo "removal of the db group and its resources ..."
        az group delete --name "$(./terraform output db_group_name)" -y
    elif [ "$arg" = "bus" ]; then
        echo "removal of the bus group and its resources ..."
        az group delete --name "$(./terraform output bus_group_name)" -y
    elif [ "$arg" = "front" ]; then
        echo "removal of the front group and its resources ..."
        az group delete --name "$(./terraform output front_group_name)" -y
    else
        az group delete --name "$arg" -y
        echo "$arg : wrong argument. Valid arguments : api, func, db, bus, front"
    fi
done
