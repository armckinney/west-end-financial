FROM armck/python-base:latest

LABEL   deployable="false" \
        decription="This is the development version of the WEF application container. \
                    It includes the application and required development tools."

# ----- Environment Setup -----

# Set Workspace directory
ARG WORKSPACE=/workspaces/west-end-financial
ENV WORKSPACE=${WORKSPACE}

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# ----- Primary Installs -----
# uses tmp install directory to keep from caching install downloads

RUN mkdir /tmp/dockerinstall \
    && cd /tmp/dockerinstall \
    # Installs
    # Azure CLI
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main"  > /etc/apt/sources.list.d/azure-cli.list \
    && apt-get update && apt-get -y install \
        azure-cli \
    && az extension add --name containerapp --upgrade \
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/dockerinstall


# ----- Bring project files into container -----
COPY ./poetry.lock ./pyproject.toml ${WORKSPACE}/
RUN cd $WORKSPACE/ && poetry install --no-root


# ----- Workspace Prep -----
WORKDIR ${WORKSPACE}

# Switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=dialog
