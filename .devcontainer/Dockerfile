
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
    && python3 -m pip install azure-functions \
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/dockerinstall

COPY ./src/api/poetry.lock ./src/api/pyproject.toml ${WORKSPACE}/src/api
RUN cd $WORKSPACE/src/api && poetry install --no-root

# ----- Workspace Prep -----
WORKDIR ${WORKSPACE}

# Switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=dialog
