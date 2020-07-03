#------------------------------------------------------------------------------------------------------------------------
# Adapted from https://github.com/microsoft/vscode-dev-containers/tree/v0.112.0/containers/r/.devcontainer (MIT license)
#------------------------------------------------------------------------------------------------------------------------

#FROM rocker/r-apt:bionic
FROM rocker/r-ver:latest

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# The r-apt image comes with a base non-root 'docker' user which this Dockerfile
# gives sudo access. However, for Linux, this user's GID/UID must match your local
# user UID/GID to avoid permission issues with bind mounts. Update USER_UID / USER_GID 
# if yours is not 1000. See https://aka.ms/vscode-remote/containers/non-root-user.

# This is my user ID on the computers I plan to use these configurations for.
# substitute for yours as appropriate
ARG USERNAME="eric"
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Configure apt and install packages
RUN apt-get update \
    && apt-get -y install --no-install-recommends apt-utils dialog 2>&1 \
    #
    # install git iproute2, process tools, lsb-release (common in install instructions for CLIs) and libzip for R Tools extension
    && apt-get -y install git openssh-client less iproute2 procps lsb-release libzip-dev libssl-dev libxml2-dev libcurl4-openssl-dev python3-pip pandoc libfreetype6-dev \
    #
    # install R packages needed for vscode interaction and package management
    && install.r languageserver renv \
    #
    # install radian via python and pip3
    && pip3 install radian \
    #
    # Register Microsoft key and feed
    && wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    #
    # Install the .NET Runtime
    && add-apt-repository universe \
    && apt-get install apt-transport-https \
    && apt-get update \
    && apt-get -y install dotnet-runtime-2.1 \
    #
    # I do not plan on using the docker user, so I need to change the gid and uid to different values
    # in order to let my user have the same gid and uid as my local computer
    && groupmod docker --gid 1005 \
    && usermod --uid 1005 docker \
    && groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    #
    # Ensure my user is given sudo priveleges
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    #
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=dialog

# [Optional] Set the default user. Omit if you want to keep the default as root.
USER $USERNAME
