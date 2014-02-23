PS1='\w\$ '
export EDITOR=vim
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

tags(){
    # ctags --exclude=.git -eR `pwd`
    # find `pwd` -name "*.py" -print | etags -a -
    # ctags --verbose -R --fields="+afikKlmnsSzt" --langmap=Python:+.t --exclude=.git
    gtags --gtagslabel=ctags `pwd` -v
}
rtags() {
    # ctags -a -e -f TAGS --tag-relative -R app lib vendor # TAGS のサイズが大きすぎる
    ctags -a -e -f TAGS --tag-relative -R app
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

alias rdm="be rake db:migrate"
alias rdreset="be rake db:reset && rdtp && notice 'rdreset'"
alias rdmreset="be rake db:migrate:reset && rdtp && notice 'rdreset'"
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

alias rgm="be spring rails g migration"
alias con="be rails c"
alias scon="be spring rails c"
alias db="be rails db"
alias sdb="be spring rails db"
alias rdtp="be spring rake db:test:prepare"

notice() {
    message=${1:-$?}
    title=${2:-"Terminal"}
    echo "display notification \"${message}\" with title \"${title}\"" | osascript
    # alias pong='perl -nle '\''print "display notification \"$_\" with title \"Terminal\""'\'' | osascript'
}

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

gbrclean(){
  git branch --merged | grep -v "*" | grep -v "develop" | grep -v "master" | xargs git branch -d
}

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
