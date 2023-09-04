# R Projects Development Setup

This repo contains the various configurations, container settings, and other setup files that I will use in my new development setup for R projects on linux. Typically I would install R directly in my system along with the various IDEs and other tools that integrate with R.  Now that I have systems with larger amounts of memory and faster CPUs, I am now experimenting with a development environment based on __container technology__, in particular Docker contaners. I have the following goals for my new development setup:

* Ability to use RStudio, Visual Studio Code, or other IDEs that can reference Docker containers or be fully contained inside one.
* Share a _central_ R  package cache between containers using the [`{renv}`](https://rstudio.github.io/renv/) package management system.
* Leave no traces of the R installation or system dependencies on the host system. While that sounds a little brazen, I plan on using a custom Linux PC built for media production and I want to keep that system fairly clean and lean!

🎥 Check out this previous [Shiny Developer Series livestream](https://youtu.be/4wRiPG9LM3o) to see my detailed walkthrough!

## Pre-requisites

* Install Docker for your particular OS. For my development setup, it is Ubuntu 20.04.  Instructions can be found at [docs.docker.com/get-docker](https://docs.docker.com/get-docker/)
     + If you are using a Linux-based operating system: Ensure that your user ID is added to the `docker` group.
* Install Visual Studio Code. Downloads and more information can be found at [code.visualstudio.com](https://code.visualstudio.com)
     + Install the [Remote Development Extension Pack](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack) 
     + Install the [Docker Extension Pack](https://marketplace.visualstudio.com/items?itemName=formulahendry.docker-extension-pack) (while not necessarily required, I find it very useful for managing my containers inside the IDE) 
     + If you use SSH keys with your online code repository account (for example GitHub or GitLab) you need to share your key with containers built.  The process is documented at on the VSCode docs [here](https://code.visualstudio.com/docs/remote/containers#_sharing-git-credentials-with-your-container). For my setup, I have to run this once before launching VSCode: `ssh-add ~/.ssh/{name_of_key}`.  I have a custom key but I would imagine most users will have a default key name of `id_rsa`.

## Visual Studio Code Setup

The `.devcontainer` directory in this repository contains the custom configuration files and build instructions for creating the development container. The `Dockerfile` and `devcontainer.json` were adapted from the VSCode dev containers GitHub repository [here](https://github.com/microsoft/vscode-dev-containers/tree/master/containers/r). Highlights of the customizations I made:

* Use the base Docker image of `rocker/tidyverse:4.3` from the [Rocker Project](https://www.rocker-project.org/)
* Install the [Fish](https://fishshell.com/) shell instead of [ZSH](http://zsh.sourceforge.net/) 
* Install additional OS libraries to make installation of R package binaries relatively painless
* Install the [radian](https://github.com/randy3k/radian) alternative R console
* Install `renv` 
* Configure environment variables for custom location of `renv` cache directory mounted into the container

With everything set up, I was able to mostly follow the official VS Code documenation page on [developing inside a container](https://code.visualstudio.com/docs/remote/containers) to get the development container launched. I am still learning the ropes so to speak with day-to-day usage of VS-Code with R coding.  Here are some additional observations that I will update as I continue my journey:

* The default linting is based on the [`{lintr}`](https://github.com/jimhester/lintr) package and might need some tweaking.  Consult the [project configuration](https://github.com/jimhester/lintr#project-configuration) of the `lintr` repository for more infomation.

## Accessing Visual Studio Code Container

1. Launch Visual Studio Code 
1. Open the folder where you cloned this repository. Note that you do not open the `.devcontainer` folder, since the Remote extension will recognize this folder automatically.
1. The container images will be built with Docker, and depending on bandwidth it could take some time. Note that the container build will be cached for future use.
1. After the build process completes, Visual Studio Code will refresh and use the container runtime. You may need to launch the terminal separate if it does not load automatically.

## RStudio Setup

In recent years, the open-source version of RStudio Server has been succesfully integrated into Docker containers in multiple projects including the excellent [Rocker Project](https://www.rocker-project.org/) led by Carl Boettiger, Dirk Eddelbuettel, and Noam Ross. Recently, they created version-stable R containers based on R version 4.0.0 or later at the [rocker-org/rocker-versioned2](https://github.com/rocker-org/rocker-versioned2) GitHub repository based on the recent Ubuntu 20.04 LTS release, as well as integrated the new [RStudio Package Manager (RSPM)](https://packagemanager.rstudio.com/) which hosts compiled binaries of R packages for installation on Linux. I decided to create a custom container for RStudio server following principles in their [new infrastructure](https://github.com/rocker-org/rocker-versioned2#modifying-and-extending-images-in-the-new-architecture) with a custom `Dockerfile` inspired by their [`Dockerfile_rstudio_4.0.2`](https://github.com/rocker-org/rocker-versioned2/blob/master/dockerfiles/Dockerfile_rstudio_4.0.2), and wrapping the execution within [Docker Compose](https://docs.docker.com/compose/).  Highlights of the customizations I implemented:

* Install additional OS libraries to make installation of R package binaries relatively painless
* Install the [radian](https://github.com/randy3k/radian) alternative R console
* Configure environment variables for custom location of `renv` cache directory mounted into the container
* Install `renv`

## Accessing RStudio Container

1. Follow the procedure above for launching the Visual Studio Code container. Even though you will be using the RStudio container server, you still need to get the container launched through Visual Studio Code
1. Open a web browser and type the following in the address bar, substituting the port number with the number listed on the left side of the `ports` directive in the `docker-compose.yml` configuration file: `http://localhost:port_number`. For example, the default port specified in this repository is `9998`, hence you would use the address `http://localhost:9998` in the address bar if you keep that port unchanged.

## Configuring a central package cache 

I have set up a local directory on my system that is mounted as a volume in each container to hold the R package cache. As long as your logged-in user has read and write priveleges to this directory on your host system, there should be no issues with each container reading and writing to the cache dir.  In the containers, the directory is located at `/renv/cache` while on my host system it is located at `/opt/local/renv/cache`, but this could be any directory on your host system. In the Docker configuration files for each container, I set up the following environment variables:

```
RENV_PATHS_CACHE_HOST=/opt/local/renv/cache
RENV_PATHS_CACHE_CONTAINER=/renv/cache
RENV_PATHS_CACHE=/renv/cache
```

## Using Renv with VS-Code

The `renv` package now works well within Visual Studio Code, but you need to make a small configuration tweak in the R Extension settings as detailed in the vscode-R wiki article here: <https://github.com/REditorSupport/vscode-R/wiki/Working-with-renv-enabled-projects>. This was the only tweak necessary within my setup.

## Next Steps

I would still consider this journey a work in progress, so here are some additonal tasks I hope to complete.  Contributions and feedback are more than welcome!

* [ ] Figure out a way to seamlessly add this development setup inside a __specific__ project. 
* [ ] Automatically override the default `.Rprofile` file created by `renv` so that I do not need to manually copy over the customized version.
