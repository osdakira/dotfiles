PS1='\w\$ '
export EDITOR=vim
export LOAD_BASHRC=1
#export PATH=/usr/local/mysql/bin:/opt/local/bin:/usr/local/bin:${PATH}

alias ls='ls -GFW'
alias ll="ls -lh"
alias la="ls -a"
alias lla="ll -a"

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

rtags(){
    ripper-tags -e -R -f TAGS --exclude=vendor
}

# tags(){
#     # ctags --exclude=.git -eR `pwd`
#     # find `pwd` -name "*.py" -print | etags -a -
#     # ctags --verbose -R --fields="+afikKlmnsSzt" --langmap=Python:+.t --exclude=.git
#     gtags --gtagslabel=ctags `pwd` -v
# }
rctags() {
    ctags -a -e -f TAGS --tag-relative -R --exclude="*.js" --exclude=".git* vendor*"
    # ctags -a -e -f TAGS --tag-relative -R app lib vendor # TAGS のサイズが大きすぎる
    # ctags -e app/**/*.rb lib/*.rb vendor/plugins/**/*.rb
}

alias seleniumfox="open -a Firefox --args -p SeleniumUser"
alias size="sips -g all"
alias ql='qlmanage -p "$@" >& /dev/null'


alias sqllog="sudo tail -n 1000 -f /tmp/myquery.log"


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
# add_path_if_exist $HOME/.homebrew/share/npm/lib/node_modules/coffee-script/bin
add_path_if_exist $HOME/.homebrew/share/npm/bin/

# add_path_if_exist $HOME/projects/adt-bundle-mac-x86_64-20130514/sdk/platform-tools
# add_path_if_exist $HOME/projects/adt-bundle-mac-x86_64-20130514/sdk/tools

#export PYTHONDONTWRITEBYTECODE=1

#[[ -s "/opt/local/lib/mysql55/bin" ]] && export PATH=/opt/local/lib/mysql55/bin:${PATH}

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

#[[ -d $HOME/Dropbox/cloud/bin ]] && export PATH=${PATH}:$HOME/Dropbox/cloud/bin

export RBENV_ROOT=/Users/osada/.homebrew/var/rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# [[ -d $HOME/.pyenv/bin ]] && export PATH=$HOME/.pyenv/bin:$PATH; eval "$(pyenv init -)"
# [[ -d $HOME/.phpenv/bin ]] && export PATH=${HOME}/.phpenv/bin:${PATH}; eval "$(phpenv init -)"
# [[ -d $HOME/.rbenv/bin ]] && export PATH=$HOME/.rbenv/bin:$PATH; eval "$(rbenv init -)"
[[ -d $HOME/.homebrew ]] && export PATH=$HOME/.homebrew/bin:$PATH

source $HOME/.git-completion.bash

alias rdm="bin/rake db:migrate"
alias rdreset="bin/rake db:reset && RAILS_ENV=test bin/rake db:reset && notice 'rdreset'"
alias rdmreset="bin/rake db:migrate:reset && RAILS_ENV=test bin/rake db:migrate:reset && notice 'rdreset'"
alias gcomrdm="git commit -m 'rake db:migrate'"

load_if_exist(){
  [[ -f $1 ]] && source $1 && echo $1
}
# load_if_exist $HOME/.works.sh
# load_if_exist $HOME/Dropbox/dotfiles/bash_completion
# berw install bash_completion
# load_if_exist $HOME/Dropbox/dotfiles/rails.bash

# [[ -f $HOME/.works.sh ]] && source $HOME/.works.sh
#[[ -f $HOME/Dropbox/dotfiles/bash-completion ]] && source $HOME/Dropbox/dotfiles/bash-completion
#[[ -f $HOME/Dropbox/dotfiles/rails.bash ]] && source $HOME/Dropbox/dotfiles/rails.bash

# R(){
#   killprog memcached
#   killprog redis-server
#   #killprog spork
#   case `pwd` in
#       *)
#           M
#           ps aux| grep -v grep | grep  unicorn_rails | grep 8080 | awk '{print $2}' | xargs kill
#           bundle exec unicorn_rails -p 8080 &
#           ;;
#   esac
#   # killprog node
#   # spork &
#   memcached &
#   redis-server &
# }

alias rgm="be bin/rails g migration"
alias con="be rails c"
alias scon="be bin/rails c"
alias db="be rails db"
alias sdb="be bin/rails db"
alias rdtp="RAILS_ENV=test be bin/rake db:setup"

notice() {
    message=${1:-$?}
    title=${2:-"Terminal"}
    echo "display notification \"${message}\" with title \"${title}\"" | osascript
}
# alias pong='perl -nle '\''print "display notification \"$_\" with title \"Terminal\""'\'' | osascript'

# notice(){
#   message=${1:-$?}
#   title=${2:-"title"}
#   #terminal-notifier -message "${message}" -title "${title}"
#   echo $message $title
#   # growlnotify -m "${message}" -s
#   osascript lib/skype/simple-notifier.scpt '${message}' '${title}' 2>/dev/null
# }

N(){
  notice $*
}

rakespec(){
  SPEC_OPTS=""
  [[ `ps | grep -v grep | grep spork` ]] && SPEC_OPTS="SPEC_OPTS=--drb"
  bundle exec rake spec ${SPEC_OPTS}
  notice "rspec"
}

#rspec(){
#  SPEC_OPTS=""
#  [[ `ps | grep -v grep | grep spork` ]] && SPEC_OPTS="--drb"
#  bundle exec rspec ${SPEC_OPTS} $*
#  notice "rspec"
#}

killprog(){
  #ps aux | grep -v grep | grep $1 | awk '{print $2}' | xargs kill
    ps aux | grep -v grep | grep $1 | awk '{print $2}' | xargs kill -9
}

tlog(){
  M
  tail -n 1000 -f log/development.log
}
testlog() {
    tail -n 1000 -f log/test.log | grep -v TRUNCATE
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

alias android="adb forward tcp:9222 localabstract:chrome_devtools_remote"

android_logcat(){
  cd ~/projects/adt-bundle-mac-x86_64-20130514/sdk/platform-tools
  ./adb logcat
}

#関数定義(引数3つ)
tab-color() {
    echo -ne "\033]6;1;bg;red;brightness;$1\a"
    echo -ne "\033]6;1;bg;green;brightness;$2\a"
    echo -ne "\033]6;1;bg;blue;brightness;$3\a"
}

tab-reset() {
    echo -ne "\033]6;1;bg;*;default\a"
}

source $HOME/Dropbox/dotfiles/m.rc.sh
source $HOME/Dropbox/dotfiles/m.ignore.sh

callonce() {
    ps aux | grep $* | grep -v grep || $*
}
# [ -f ~/Dropbox/dotfiles/.bundler-exec.sh ] && source ~/.bundler-exec.sh
# load_if_exist $HOME/.bundler-exec.sh
alias be="bundle exec"
export PIVOTAL_TOKEN='ef8c10f9b6a3f1b04fff6d5bf1affd87'


alias powrestart="powify server restart"
alias powb="powify browse"
alias powr="powify restart"
alias powl="powify server logs"

# export PARALLEL_TESTS_EXECUTABLE="bundle exec rspec"
export PATH="$HOME/.cask/bin:$PATH"

if [ -d /usr/local/java ]; then
    export JAVA_HOME=/usr/local/java
    export PATH=$JAVA_HOME/bin:$PATH
fi

alias shoes="/Applications/Shoes.app/Contents/MacOS/shoes"

alias ssh_add_month="ssh-add -t 2592000 ~/.ssh/id_rsa"

# export CHARTWORK_TOKEN="8eed8a24dc3ed65e2049c230f30a1590"

if which pyenv > /dev/null; then
    export PYENV_ROOT=`brew --prefix`/opt/pyenv
    export PATH=$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH;
    eval "$(pyenv init -)";
fi

# if [ -f $(brew --prefix)/etc/bash_completion ]; then
#     . $(brew --prefix)/etc/bash_completion
# fi
export PATH=$PATH:/Users/osada/projects/swift-0.94.1/bin

export MAIL_SEND=false
# alias git=hub
eval "$(hub alias -s)"
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

export PATH=$PATH:/Users/osada/.homebrew/opt/go/libexec/bin
alias boot2docker='boot2docker --vm=boot2docker-vm-vboxfs'
export DOCKER_HOST=tcp://192.168.59.103:2375
alias dl='docker ps -l -q'
alias docker_rm="docker ps -a -q | xargs docker rm"
alias docker_rmi="docker images | grep none | awk '{print $3}' | xargs docker rmi"
export AUTODOC=1
export ANDROID_HOME=/Users/osada/.homebrew/Cellar/android-sdk/23.0.2
export PATH=~/.cabal/bin:/opt/local/bin:/opt/local/sbin:/Users/osada/.homebrew/opt/pyenv/shims:/Users/osada/.homebrew/opt/pyenv/bin:/usr/local/java/bin:/Users/osada/.cask/bin:/Users/osada/.homebrew/bin:/Users/osada/.homebrew/var/rbenv/shims:/usr/local/heroku/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/local/bin:/opt/local/sbin:/Users/osada/.homebrew/opt/pyenv/shims:/Users/osada/.homebrew/opt/pyenv/bin:/usr/local/java/bin:/Users/osada/.cask/bin:/Users/osada/.homebrew/bin:/usr/local/heroku/bin:/Users/osada/Dropbox/dotfiles/mybin:/Users/osada/projects/swift-0.94.1/bin:/Users/osada/.homebrew/opt/go/libexec/bin:/Users/osada/Dropbox/dotfiles/mybin:/Users/osada/projects/swift-0.94.1/bin:/Users/osada/.homebrew/opt/go/libexec/bin

c_login(){
    set -x
    # set -eux
    ip=`grep server $1 | cut -d "'" -f 2`
    pem=`grep pem $1 | perl -pe '$_ =~ s/.*?(\w+\.pem).*/\1/'`
    ssh -i $HOME/.ssh/${pem} ubuntu@${ip}
    # set +eux
    set +x
}

alias cls="c_login config/deploy/staging.rb"
alias clp="c_login config/deploy/production.rb"

# export JUBATUS_HOME="`brew --prefix`/jubatus"
# export PATH="${JUBATUS_HOME}/bin:${PATH}"
# export LD_LIBRARY_PATH="${JUBATUS_HOME}/lib:${LD_LIBRARY_PATH}"
# export LDFLAGS="-L${JUBATUS_HOME}/lib ${LDFLAGS}"
# export CPLUS_INCLUDE_PATH="${JUBATUS_HOME}/include:${CPLUS_INCLUDE_PATH}"
# export PKG_CONFIG_PATH="${JUBATUS_HOME}/lib/pkgconfig:${PKG_CONFIG_PATH}"
export R_HOME=/Library/Frameworks/R.framework/Resources
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$RHOME/bin
alias ..="cd .."
alias logger="ssh -i ~/.ssh/logger.pem ubuntu@54.248.242.214"

export CHAT_WORK_TOKEN=8eed8a24dc3ed65e2049c230f30a1590
# curl -X GET -H "X-ChatWorkToken: 自分のAPIトークン"
# "https://api.chatwork.com/v1/rooms/{room_id}/messages?force=0"
chatwork(){
    curl -X $1 -H "X-ChatWorkToken: ${CHAT_WORK_TOKEN}" \
         "https://api.chatwork.com/v1/$2"
}
alias G="cd ~/projects/go"
export GOPATH=$HOME/projects/go_test
export PATH=$PATH:$GOPATH/bin
export GOENVGOROOT=$HOME/.goenvs
export GOENVTARGET=`pwd`/.homebrew/Cellar/go/1.3.3/bin
# source $GOENVTARGET/goenvwrapper.sh
alias rseed="bin/rake db:seed"
alias rmreset="bin/rake db:migrate:reset"
