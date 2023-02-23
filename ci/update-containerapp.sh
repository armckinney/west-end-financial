#!/bin/bash
# Scope: updates the Azure Container App deployment

# login to Azure CLI
# az login --service-principal -u $AZURE_SP_USER -p $AZURE_SP_PASSWORD -t $AZURE_TENANT

# Build Container (use pre-built CI image, just retag it to dev)
# docker tag <image>:<CITAG> <image>:<dev-tag>

# Push Container to Registry

# Update Container App
# az containerapp update  -n ContainerAppName
#                         -g ResourceGroupName
#                         -i docker.io/armck/<image>:<dev-tag>
#                         --revision-suffix $TODO

