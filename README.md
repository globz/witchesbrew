witchesbrew is a provisioning tool for Linux.

Entirely written in bash, it aims to stay as simple as possible
and leverage the power of shell scripting. 

The core of this small application is focused on the ease of composition of individual
shell scripts.

Armed with two simple commands it becomes easy to mix a single script with the
host environment or carefully brew them in such a way that they can deploy a complex
application architecture.

Installation :
- git clone https://github.com/globz/witchesbrew.git witchesbrew
- cd witchesbrew/ && ./install.sh

TODO :

+ [x] Add bash completion
+ [X] Install witchesbrew in $HOME/.local/bin
+ [x] Create uninstall script
+ [ ] Create update feature (git pull)
+ [ ] Try to remove hard coded $wd path or make it a single entry point
+ [ ] Move witchesbrew folder to $HOME/.local/bin instead of symbolic link
