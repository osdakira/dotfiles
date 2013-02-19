PS1='\w\$ '
export LOAD_BASHRC=1
export PATH=/usr/local/mysql/bin:/opt/local/bin:/usr/local/bin:${PATH}

alias ls='ls -GFW'
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -la"

alias cd="pushd"
alias pd="popd"

alias grep="grep --color=auto"
export HISTCONTROL=ignoreboth
export CLICOLOR=1
# export LSCOLORS=DxGxcxdxCxegedabagacad
export LSCOLORS=DxDx
shopt -u histappend
export HISTSIZE=9999
export HISTTIMEFORMAT='%y/%m/%d %H:%M:%S '
export HISTIGNORE=ls

alias javac="javac -J-Dfile.encoding=UTF8"
alias unrepr="python -c \"import sys; [ sys.stdout.write('\t'.join( [ (s.startswith('u') and eval(s) or s) for s in line.split('\t') ])) for line in sys.stdin]\""

alias rm='rmtrash'

# export WORKON_HOME=$HOME/.virtualenvs
#source /usr/local/bin/virtualenvwrapper_bashrc
# [[ -s "/opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin/" ]] && export PATH=/opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin/:${PATH}
# [[ -s "/opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin/virtualenvwrapper.sh" ]] && source /opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin/virtualenvwrapper.sh
#[[ -s "$HOME/.pythonbrew/etc/bashrc" ]] && source "$HOME/.pythonbrew/etc/bashrc"
#pybrew switch Python-2.7.3
#pybrew use Python-2.7.3
#[[ -s $HOME/.pythonz/etc/bashrc ]] && source $HOME/.pythonz/etc/bashrc

source $HOME/.gitrc
source $HOME/.work.sh
source $HOME/.app.sh

#alias tmux=~/.mybin/tmuxx.sh

installrbenv(){
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
}

[[ -d /usr/local/share/npm/bin ]] && export PATH=${PATH}:/usr/local/share/npm/bin
[[ -d $HOME/node_modules/.bin ]] && export PATH=${PATH}:$HOME/node_modules/.bin

export PYTHONDONTWRITEBYTECODE=1

[[ -s "/opt/local/lib/mysql55/bin" ]] && export PATH=/opt/local/lib/mysql55/bin:${PATH}

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

[[ -d $HOME/Dropbox/cloud/bin ]] && export PATH=${PATH}:$HOME/Dropbox/cloud/bin

[[ -d $HOME/.phpenv/bin ]] && export PATH=${HOME}/.phpenv/bin:${PATH}; eval "$(phpenv init -)"
[[ -d $HOME/.rbenv/bin ]] && export PATH=$HOME/.rbenv/bin:$PATH; eval "$(rbenv init -)"
