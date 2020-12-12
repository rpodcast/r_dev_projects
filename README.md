# R Projects Development Setup

This repo contains the various configurations, container settings, and other setup files that I will use in my new development setup for R projects on linux. 

## Pre-requisites

* Install Docker for your particular OS. For my development setup, it is Ubuntu 20.04.  Instructions can be found at [docs.docker.com/get-docker](https://docs.docker.com/get-docker/)
     + If you are using a Linux-based operating system: Ensure that your user ID is added to the `docker` group.
* Install Visual Studio Code. Downloads and more information can be found at [code.visualstudio.com](https://code.visualstudio.com)
     + Install the Remote Development Extension Pack: https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack
     + If you use SSH keys with your online code repository account (for example GitHub or GitLab) you need to share your key with containers built.  The process is documented at on the VSCode docs [here](https://code.visualstudio.com/docs/remote/containers#_sharing-git-credentials-with-your-container). For my setup, I have to run this once before launching VSCode: `ssh-add ~/.ssh/{name_of_key}`.  I have a custom key but I would imaging most users will have a default key name of `id_rsa`.

## Visual Studio Code Initial Setup

The `.devcontainer` directory in this repository contains the custom configuration files and build instructions for creating the development container. The `Dockerfile` and `devcontainer.json` were adapted from the VSCode dev containers GitHub repository [here](https://github.com/microsoft/vscode-dev-containers/tree/master/containers/r). Highlights of the customizations I made:

* Install the [Fish](https://fishshell.com/) shell instead of [ZSH](http://zsh.sourceforge.net/) 
* Install additional OS libraries to make installation of R package binaries relatively painless
* Install the [radian](https://github.com/randy3k/radian) alternative R console
* Install certain dotnet core runtime packages (this may not be necessary in future)
* Configure environment variables for custom location of `renv` cache directory mounted into the container
* Set the default user as my user account and not root



## Renv with VS-Code and dev containers

The `.Rprofile` file must have a snippet to load the appropriate VS code R plugin stuff before activating the project.  Here is an example that can be used:

```r
# setup if using with vscode and R plugin
if (Sys.getenv("TERM_PROGRAM") == "vscode") {
    source(file.path(Sys.getenv(if (.Platform$OS.type == "windows") "USERPROFILE" else "HOME"), ".vscode-R", "init.R"))
}

source("renv/activate.R")

if (Sys.getenv("TERM_PROGRAM") == "vscode") {
    # obtain list of packages in renv library currently
    project <- renv:::renv_project_resolve(NULL)
    lib_packages <- names(unclass(renv:::renv_diagnostics_packages_library(project))$Packages)

    # detect whether key packages are already installed
    # was: !require("languageserver")
    if (!"languageserver" %in% lib_packages) {
        message("installing languageserver package")
        renv::install("languageserver")
    }

    if (!"httpgd" %in% lib_packages) {
        message("installing httpgd package")
        renv::install("nx10/httpgd")
    }
}
```

Also when creating the `renv` project, need to install a few packages necessary for the plugins:

```
languageserver
nx10/httpgd

```

## VS-Code and R Notes

TODO: Organize

* Before opening a folder that was a clone of a git repo, we need to start an ssh-agent and add the appropriate key(s) that are used to authenticate to GitHub or other Git online repos:

```
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/{key_filename}
```

Then you should be able to interact with the git repo like usual.

* The default linting is based on the `lintr` package and might need some tweaking.  Consult <https://github.com/jimhester/lintr#project-configuration> for more info.

