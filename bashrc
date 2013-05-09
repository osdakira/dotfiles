PS1='\w\$ '
export LOAD_BASHRC=1
#export PATH=/usr/local/mysql/bin:/opt/local/bin:/usr/local/bin:${PATH}

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
#source $HOME/.work.sh
#source $HOME/.app.sh

#alias tmux=~/.mybin/tmuxx.sh

installrbenv(){
  git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
  git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
}

# [[ -d /usr/local/share/npm/bin ]] && export PATH=${PATH}:/usr/local/share/npm/bin
# [[ -d $HOME/node_modules/.bin ]] && export PATH=${PATH}:$HOME/node_modules/.bin

add_path_if_exist(){
  [[ -d $1 ]] && export PATH=${PATH}:$1 && echo $1
}
add_path_if_exist $HOME/.homebrew/share/npm/lib/node_modules/coffee-script/bin

export PYTHONDONTWRITEBYTECODE=1

[[ -s "/opt/local/lib/mysql55/bin" ]] && export PATH=/opt/local/lib/mysql55/bin:${PATH}

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

#[[ -d $HOME/Dropbox/cloud/bin ]] && export PATH=${PATH}:$HOME/Dropbox/cloud/bin

[[ -d $HOME/.pyenv/bin ]] && export PATH=$HOME/.pyenv/bin:$PATH; eval "$(pyenv init -)"
[[ -d $HOME/.phpenv/bin ]] && export PATH=${HOME}/.phpenv/bin:${PATH}; eval "$(phpenv init -)"
[[ -d $HOME/.rbenv/bin ]] && export PATH=$HOME/.rbenv/bin:$PATH; eval "$(rbenv init -)"
[[ -d $HOME/.homebrew ]] && export PATH=$HOME/.homebrew/bin:$PATH

source $HOME/.git-completion.bash

alias rdm="rake db:migrate"
alias rdreset="rake db:reset && rdtp && notice 'rdreset'"
alias gcomrdm="git commit -m 'rake db:migrate'"
alias rgs="rails g scaffold"
alias rsm="rake spec:models"
alias rsr="rake spec:requests"
raddc(){
    rails g migration add_column_to_$*
}
rremovec(){
    rails g migration remove_column_from_$*
}

load_if_exist(){
  [[ -f $1 ]] && source $1 && echo $1
}
load_if_exist $HOME/.works.sh
# load_if_exist $HOME/Dropbox/dotfiles/bash_completion
# berw install bash_completion
# load_if_exist $HOME/Dropbox/dotfiles/rails.bash

# [[ -f $HOME/.works.sh ]] && source $HOME/.works.sh
#[[ -f $HOME/Dropbox/dotfiles/bash-completion ]] && source $HOME/Dropbox/dotfiles/bash-completion
#[[ -f $HOME/Dropbox/dotfiles/rails.bash ]] && source $HOME/Dropbox/dotfiles/rails.bash
R(){
    case `pwd` in
        *edo2) E2;;
        *) E;;
    esac
  killprog memcached
  killprog unicorn_rails
  #killprog spork
  unicorn_rails &
  killall node
  #spork &
  memcached &
  cd app/scripts/
  node grunt c s watch
}
alias rgm="rails g migration"
alias shell="rails c"
alias db="rails db"
alias rdtp="rake db:test:prepare"

notice(){
  message=${1:-$?}
  title=${2:-"title"}
  #terminal-notifier -message "${message}" -title "${title}"
  growlnotify -m "${message}" -name "${title}"
}
alias N="notice"

rakespec(){
  SPEC_OPTS=""
  [[ `ps | grep -v grep | grep spork` ]] && SPEC_OPTS="SPEC_OPTS=--drb"
  bundle exec rake spec ${SPEC_OPTS} ; N "rspec"
}

rspec(){
  SPEC_OPTS=""
  [[ `ps | grep -v grep | grep spork` ]] && SPEC_OPTS="--drb"
  bundle exec rspec ${SPEC_OPTS} $*; N "rspec"
}

killprog(){
  ps aux | grep -v grep | grep $1 | awk '{print $2}' | xargs kill
}
deploy(){
   expect -c "
   spawn cap sandbox deploy -s branch="$(parse_git_branch)"
   expect \"deployed server : \[ec2-54-249-158-75.ap-northeast-1.compute.amazonaws.com\]\"
   send \"\n\n\"
   expect \"branch or tag : \[$(parse_git_branch)\]\"
   send \"\n\n\"
   interact
   "
   urestart
   notice "deploy"
}
urestart(){
   expect -c "
   spawn cap sandbox unicorn:restart
   expect \"deployed server : \[ec2-54-249-158-75.ap-northeast-1.compute.amazonaws.com\]\"
   send \"\n\n\"
   interact
  "
}

alias routes="rake routes"
tlog(){
  E
  tail -f log/development.log
}

[[ -d $HOME/Dropbox/dotfiles/mybin ]] && export PATH=${PATH}:$HOME/Dropbox/dotfiles/mybin

traverse_dir() {
    current=`pwd`
    echo ${current}
    while [ `basename ${current}` != $1 ]
    do
        current=`dirname ${current}`
        echo ${current}
        if [ ${current} == "/" ]; then
            break
        fi
    done
}
