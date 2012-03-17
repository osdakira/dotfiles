PS1='\w\$ '

export PATH=/usr/local/mysql/bin:$HOME/.mybin:/opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin/:$PATH


alias ls='ls -GFW'
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -la"
alias h="history"
alias run="source"

alias en="open -n -a /Applications/Emacs.app/Contents/MacOS/bin/emacsclient"
alias em="open -a /Applications/Emacs.app/Contents/MacOS/bin/emacsclient"

alias rm="rm -i"

alias pd="pushd"
alias p="popd"

alias grep="grep --color=auto"

export HISTCONTROL=ignoreboth

export CLICOLOR=1
# export LSCOLORS=DxGxcxdxCxegedabagacad
export LSCOLORS=DxDx


function share_history {
    history -a
    history -c
    history -r
}
PROMPT_COMMAND='share_history'

shopt -u histappend
export HISTSIZE=9999


source ~/.local/bin/bashmarks.sh

export EDITOR=emacsclient

alias javac="javac -J-Dfile.encoding=UTF8"

alias unrepr="python -c \"import sys; [ sys.stdout.write('\t'.join( [ (s.startswith('u') and eval(s) or s) for s in line.split('\t') ])) for line in sys.stdin]\""
#export IGNOREEOF=3



# virtualenv
source $HOME/.gitrc
export WORKON_HOME=$HOME/.virtualenvs 
source /usr/local/bin/virtualenvwrapper_bashrc
source $HOME/.app.sh
source $HOME/.work.sh

alias M="cd $HOME/memo/"

export PYTHONSTARTUP=~/.pythonrc



