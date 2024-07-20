#!/bin/sh

# Enable debug output
PS4="\n\033[1;33m>>\033[0m "; set -x

LOCATION=$(realpath "$0")
DIR=$(dirname "$LOCATION")

sudo -v

helm repo add ot-container-kit https://ot-container-kit.github.io/helm-charts
helm repo update

helm upgrade --install --create-namespace -n redis-operator redis-operator $DIR/redis-operator-0.18.0 -f $DIR/redis-operator-0.18.0/values.yaml -f $DIR/redis-operator-0.18.0/values-override.yaml --wait

kubectl apply -f $DIR/redis-operator-0.18.0/custom-resources --wait
