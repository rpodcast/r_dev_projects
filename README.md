# R Projects Development Setup

This repo contains the various configurations, container settings, and other setup files that I will use in my new development setup for R projects on linux. 

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

