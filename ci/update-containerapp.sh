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
   echo -e "\t-f    (Optional) Path of the Dockerfile to build and deploy. Default: ./app/Dockerfile"
   echo -e "\t-t    (Optional) Image Tag. Default: latest"
   echo -e "\t-acr  (Optional) Flag indicating to create and utilize an Azure Container Registry."
   echo ""
   exit 1
}

# acquiring opts, prints helpFunction in case parameter is non-existent
while getopts "n:r:e:f:t:a:" opt
do
    case "$opt" in
        n ) appName="$OPTARG" ;;
        r ) registryName="$OPTARG" ;;
        e ) environment="$OPTARG" ;;
        f ) dockerfile="$OPTARG" ;;
        t ) imageTag="$OPTARG" ;;
        a ) acr="$OPTARG" ;;
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
if [ -z $dockerfile ]; then dockerfile=./app/Dockerfile; fi
if [ -z $imageTag ]; then imageTag=latest; fi
if [ $acr ]; then registryServer=$registryName.azurecr.io; else registryServer=docker.io/$registryName; fi

resourceGroup=rg-$appName-$environment
containerApp=ca-$appName-$environment
imageName=$registryServer/$appName:$imageTag

if [ -z "$containerApp" ] || [ -z "$resourceGroup" ] || [ -z $dockerfile ] || [ -z $imageName ]
then
   echo -e "${indent}${red}Some or all of the parameters are empty${nocolor}";
   helpFunction
fi


#####  SCRIPT  #####
failure=0

if [ $acr ]
then 
    echo -e "${indent}${blue}Logging into Aure Container Registry ($registryName).${nocolor}"
    az acr login --name $registryName
fi

echo -e "${indent}${blue}Building Image ($imageName) from Dockerfile ($dockerfile).${nocolor}"
docker build -t $imageName -f $dockerfile .

echo -e "${indent}${blue}Pushing Image to Registry ($imageName).${nocolor}"
docker push $imageName

echo -e "${indent}${blue}Updating Container App ($containerApp).${nocolor}"
az containerapp update    -n $containerApp \
                          -g $resourceGroup \
                          -i $imageName


#####   FAIL ON EXIT    #####
if [ $? -ne 0 ]; then
    failure=1
fi

if [ $failure -ne 0 ]; then
   echo -e "${indent}${red}An issue has occured in deployment.${nocolor}"
   exit 1
fi