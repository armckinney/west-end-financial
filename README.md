<!-- header -->
<div align="center">
    <p>
    <!-- Header -->
        <img width="100px" src="app/static/images/About_us.jpg"  alt="west-end-financial" />
        <h2>Credit Crunch</h2>
        <p><i>by West End Financial</i></p>
    </p>
    <p>
    <!-- Shields -->
        <a href="https://github.com/armckinney/west-end-financial/LICENSE">
            <img alt="License" src="https://img.shields.io/github/license/armckinney/west-end-financial.svg" />
        </a>
        <a href="https://github.com/armckinney/west-end-financial/actions">
            <img alt="Tests Passing" src="https://github.com/armckinney/west-end-financial/workflows/CI/badge.svg" />
        </a>
        <a href="https://codecov.io/gh/armckinney/west-end-financial">
            <img alt="Code Coverage" src="https://codecov.io/gh/armckinney/west-end-financial/branch/master/graph/badge.svg" />
        </a>
        <a href="https://github.com/armckinney/west-end-financial/issues">
            <img alt="Issues" src="https://img.shields.io/github/issues/armckinney/west-end-financial" />
        </a>
        <a href="https://github.com/armckinney/west-end-financial/pulls">
            <img alt="GitHub pull requests" src="https://img.shields.io/github/issues-pr/armckinney/west-end-financial" />
        </a>
        <a href="https://stackshare.io/armck/west-end-financial">
            <img alt="StackShare.io" src="http://img.shields.io/badge/tech-stack-0690fa.svg?label=StackShare.io">
        </a>
    </p>
    <p>
    <!-- Links -->
        <a href="https://ca-westendfinancial-prod.ashymoss-cd1cd23a.eastus.azurecontainerapps.io" target="_blank">View Demo</a>
        ·
        <a href="https://github.com/armckinney/west-end-financial/issues/new/choose">Report Bug</a>
        ·
        <a href="https://github.com/armckinney/west-end-financial/issues/new/choose">Request Feature</a>
    </p>
</div>
<br>
<br>

<!-- Description -->
Credit Crunch is a credit risk analysis web application built by the team at West End Financial.

The app utilizes various methods analysis, involves 2 key determination methods. One being a pre-developed neural network model that is utilized when the top 10 requested input fields are submitted and the other being a dynamic nerual network model that builds itself from a set of fields designated by the user.

## Here's why Credit Crunch by West End Financial is important:
* It can lower your risk of financial credit lines given to your customers
* It can pre-approve your customers for a credit line
* It can enable cross-selling of other financial products such as savings and checking accounts
* It can reduce overhead and responsabilities of your Credit Loan Officers

</br>

## Deployment:
Current deployments utilize Azure Container Apps. The following deployment must be performed on the host machine and not in the development container, since docker is not installed / reachable inside the container.
1. Log into Azure CLI and ensure you are on the proper subcription using the following commands:
```
#!/bin/bash
az login
az account set -s <my-subscription>
az account show
```

</br>

2. Run the deployment ci script using the desired arguments, below is an example deploying fully to Azure:
```
#!/bin/bash
./ci/deploy-containerapp.sh -n westendfinancial -r acrwestendfinancial -acr
```

This deploys the following resources into a single resource group:
- Azure Resource Group
- Azure Container Registry (If `-acr` flag specified)
- Azure Log Analytics Workspace
- Container App Environment
- Container App

> Note: you can use Docker as a container registry as well.

</br>

3. To update the Container App, run the update ci script:
```
#!/bin/bash
./ci/update-containerapp.sh -n westendfinancial -r acrwestendfinancial -acr
```

</br>

## Development:
Development of this application relies on VS Code's Remote Containers.

Ensure the following tools are installed on your local machine:
- VS Code
    - Remote Development (VS Code Extension)
    - Docker (VS Code Extension)
- Docker Engine

To start Developing:
1. Clone the repository to your machine.
```
#!/bin/bash
git clone https://github.com/armckinney/west-end-financial.git
```

2. Open the repository in VS Code:
```
#!/bin/bash
code ./west-end-financial
```

3. Open the project within the development container:
    - Open the VS Code command palette:`ctrl+shift+p`
    - Execute the command: `Remote Development: Reopen in Container`

After the dev container builds, you should be set up with the proper dev environment and ready to get started! 
