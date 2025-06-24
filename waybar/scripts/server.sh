#!/bin/bash

if ! command -v kubectl &> /dev/null; then
    echo '{"text":"","alt":"","tooltip":"kubectl not found","class":""}'
    exit 0
fi

if ! kubectl cluster-info &> /dev/null; then
    echo '{"text":"","alt":"","tooltip":"No cluster connection","class":""}'
    exit 0
fi

pods_json=$(kubectl get pods -o json 2>/dev/null)

if [ $? -ne 0 ]; then
    echo '{"text":"","alt":"","tooltip":"Failed to get pods","class":""}'
    exit 0
fi

running_pods=$(echo "$pods_json" | jq '.items | map(select(.status.phase == "Running")) | length')
total_pods=$(echo "$pods_json" | jq '.items | length')
failed_pods=$(echo "$pods_json" | jq '.items | map(select(.status.phase != "Running")) | length')

if [ "$total_pods" -eq 0 ]; then
    echo '{"text":"","alt":"","tooltip":"No pods found","class":""}'
    exit 0
fi

if [ "$failed_pods" -gt 0 ]; then
    echo "{\"text\":\" $failed_pods\",\"alt\":\"critical\",\"tooltip\":\"$failed_pods pods failing out of $total_pods\",\"class\":\"critical\"}"
else
    echo "{\"text\":\" \",\"alt\":\"good\",\"tooltip\":\"All $running_pods pods running\",\"class\":\"good\"}"
fi 
