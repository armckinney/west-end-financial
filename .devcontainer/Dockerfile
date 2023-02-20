FROM armck/python-base:latest

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

COPY ./src/api/poetry.lock ./src/api/pyproject.toml ${WORKSPACE}/src/api/
RUN cd $WORKSPACE/src/api/ && poetry install --no-root


# COPY ./app /code/app
# CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "3500"]


# ----- Workspace Prep -----
WORKDIR ${WORKSPACE}

# Switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=dialog
