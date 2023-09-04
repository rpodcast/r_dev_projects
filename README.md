# R Projects Development Template

This repo provides a starting template for a containerized development environment for my R projects in data science and Shiny application development, tailored to both the RStudio IDE as well as Visual Studio Code. For a more detailed description, please see the [`.devcontainer/README.md`](.devcontainer/README.md)),

**HEADS UP**: The latest version of the development files is a fairly substantial overhaul of the setup in the screencast below. I will record another video with the updates soon!

🎥 Check out this previous [Shiny Developer Series livestream](https://youtu.be/4wRiPG9LM3o) for a hands-on walkthrough of this setup!

## Quick Start

Refer to the detailed instructions in [`.devcontainer/README.md`](.devcontainer/README.md)) for how to set up your environment to use this container setup. Once the setup is complete, you can access the Visual Studio Code and RStudio containers with the following instructions:

### Visual Studio Code Container

1. Launch Visual Studio Code 
1. Open the folder where you cloned this repository. Note that you do not open the `.devcontainer` folder, since the Remote extension will recognize this folder automatically.
1. The container images will be built with Docker, and depending on bandwidth it could take some time. Note that the container build will be cached for future use.
1. After the build process completes, Visual Studio Code will refresh and use the container runtime. You may need to launch the terminal separate if it does not load automatically.

### RStudio Server Container

1. Follow the procedure above for launching the Visual Studio Code container. Even though you will be using the RStudio container server, you still need to get the container launched through Visual Studio Code
1. Open a web browser and type the following in the address bar, substituting the port number with the number listed on the left side of the `ports` directive in the [`.devcontainer/docker-compose.yml`](.devcontainer/docker-compose.yml) configuration file: `http://localhost:port_number`. For example, the default port specified in this repository is `9998`, hence you would use the address `http://localhost:9998` in the address bar if you keep that port unchanged.


