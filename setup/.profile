# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

### local modifications - BEGIN
export COLORTERM=truecolor # für mc
export EDITOR=gvim # für mc
if test -n "$GDMSESSION" 
then
  hostname | grep 'HP-Laptop' && export MC_SKIN=seasons-winter16M.ini
else
#  hostname | grep 'HP-Laptop' && setupcon -f --current-tty
  export MC_SKIN=/home/horst/.mc/skins/default.ini # path search not working
fi
umask 002
export CDPATH=/daten/Users/horst/Dokumente
### local modifications - END
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
