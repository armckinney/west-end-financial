#!/bin/bash

# constants
blue='\e[0;34m'
red='\e[0;31m'
nocolor='\e[0m'
indent="     "


#####  OPTARG PARSING  #####
# terminal help function, exits script after execution
helpFunction()
{
   echo ""
   echo "Usage: $0 -n myapp -r dockerhubuser -e dev -f ./my/Dockerfile -t 1.0 -acr"
   echo -e "\t-n    Name of the application. Must contain only alpha characters."
   echo -e "\t-r    Name of the container registry to serve from. Default: DockerHub username, else ACR name if -acr given."
   echo -e "\t-e    (Optional) Name of the deployed environment. Must contain only alpha characters. Default: prod"
   echo -e "\t-l    (Optional) Location of the deployed environment. Default: eastus"
   echo -e "\t-f    (Optional) Path of the Dockerfile to build and deploy. Default: ./app/Dockerfile"
   echo -e "\t-t    (Optional) Image Tag. Default: latest"
   echo -e "\t-acr  (Optional) Flag indicating to create and utilize an Azure Container Registry."
   echo ""
   exit 1
}

# acquiring opts, prints helpFunction in case parameter is non-existent
while getopts "n:r:e:l:f:t:a:" opt
do
    case "$opt" in
        n ) appName="$OPTARG" ;;
        r ) registryName="$OPTARG" ;;
        e ) environment="$OPTARG" ;;
        l ) location="$OPTARG" ;;
        f ) dockerfile="$OPTARG" ;;
        t ) imageTag="$OPTARG" ;;
        a ) acr="true" ;;
        ? ) helpFunction ;;
    esac
done

# Print helpFunction in case parameters are empty
if [ -z "$appName" ] || [ -z "$registryName" ]
then
   echo -e "${indent}${red}Some or all of the parameters are empty${nocolor}";
   helpFunction
fi


##### Variable Override and Validation #####
if [ -z $environment ]; then environment=prod; fi
if [ -z $location ]; then location=eastus; fi
if [ -z $dockerfile ]; then dockerfile=./app/Dockerfile; fi
if [ -z $imageTag ]; then imageTag=latest; fi
if [ $acr ]; then registryServer=$registryName.azurecr.io; else registryServer=docker.io/$registryName; fi

resourceGroup=rg-$appName-$environment
containerApp=ca-$appName-$environment
containerAppEnv=cae-$appName-$environment
imageName=$registryServer/$appName:$imageTag

if [ -z "$resourceGroup" ] || [ -z $dockerfile ] || [ -z $imageName ] || [ -z $registryName ] || [ -z $location ]
then
   echo -e "${indent}${red}Some or all of the parameters are empty${nocolor}";
   helpFunction
fi

##### SCRIPT #####
# See: https://learn.microsoft.com/en-us/azure/container-apps/quickstart-code-to-cloud?tabs=bash%2Cpython&pivots=docker-local
failure=0

echo -e "${indent}${blue}Deploying Resource Group ($resourceGroup)${nocolor}";
az group create \
  --name $resourceGroup \
  --location "$location"

if [ $acr ]
then
    echo -e "${indent}${blue}Deploying Azure Container Registry ($registryName)${nocolor}"
    az acr create \
        --resource-group $resourceGroup \
        --name $registryName \
        --sku Basic \
        --admin-enabled true # might be able to just use MI to ContainerApp to ACR if AcrPull role assigned

    echo -e "${indent}${blue}Logging into Azure Container Registry ($registryName)${nocolor}"
    az acr login --name $registryName
fi

echo -e "${indent}${blue}Deploying Container App Environment ($containerAppEnv).${nocolor}"
az containerapp env create \
  --name $containerAppEnv \
  --resource-group $resourceGroup \
  --location "$location"

echo -e "${indent}${blue}Building Image ($imageName) from Dockerfile ($dockerfile).${nocolor}"
docker build -t $imageName -f $dockerfile .

echo -e "${indent}${blue}Pushing Image to Registry ($imageName).${nocolor}"
docker push $imageName

echo -e "${indent}${blue}Creating Container App ($containerApp).${nocolor}"
az containerapp create \
  --name $containerApp \
  --resource-group $resourceGroup \
  --environment $containerAppEnv \
  --image $imageName \
  --target-port 3500 \
  --ingress 'external' \
  --registry-server $registryServer


#####   FAIL ON EXIT    #####
if [ $? -ne 0 ]; then
    failure=1
fi

if [ $failure -ne 0 ]; then
   echo -e "${indent}${red}An issue has occure in this todo script.${nocolor}"
   exit 1
fi