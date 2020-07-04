# R Projects Development Setup

This repo contains the various configurations, container settings, and other setup files that I will use in my new development setup for R projects on linux. 

## VS-Code and R Notes

TODO: Organize

* Before opening a folder that was a clone of a git repo, we need to start an ssh-agent and add the appropriate key(s) that are used to authenticate to GitHub or other Git online repos:

```
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/{key_filename}
```

Then you should be able to interact with the git repo like usual.
