# use hub
eval "$(hub alias -s)"

# Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
add_path $HOME/Dropbox/dotfiles/mybin

# USE R-Lang
export R_HOME=/Library/Frameworks/R.framework/Resources
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$RHOME/bin

# curl -X GET -H "X-ChatWorkToken: 自分のAPIトークン"
# "https://api.chatwork.com/v1/rooms/{room_id}/messages?force=0"
chatwork(){
    curl -X $1 -H "X-ChatWorkToken: ${CHAT_WORK_TOKEN}" \
         "https://api.chatwork.com/v1/$2"
}

red=31
green=32
yellow=33
blue=34

function cecho {
    color=$1
    shift
    echo -e "\033[${color}m$@\033[m"
}

function usage {
    cat <<EOF
$(basename ${0}) is a tool for ...

Usage:
    $(basename ${0}) [command] [<options>]

Options:
    --version, -v     print $(basename ${0}) version
    --help, -h        print this
EOF
}

notice() {
    message=${1:-$?}
    title=${2:-"Terminal"}
    echo "display notification \"${message}\" with title \"${title}\"" | osascript
}

N(){
  notice $*
}

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

#関数定義(引数3つ)
tab-color() {
    echo -ne "\033]6;1;bg;red;brightness;$1\a"
    echo -ne "\033]6;1;bg;green;brightness;$2\a"
    echo -ne "\033]6;1;bg;blue;brightness;$3\a"
}

tab-reset() {
    echo -ne "\033]6;1;bg;*;default\a"
}

# alias shoes="/Applications/Shoes.app/Contents/MacOS/shoes"
# alias pong='perl -nle '\''print "display notification \"$_\" with title \"Terminal\""'\'' | osascript'

#[[ -d $HOME/Dropbox/cloud/bin ]] && export PATH=${PATH}:$HOME/Dropbox/cloud/bin

# brew install bash_completion
# load $HOME/Dropbox/dotfiles/bash_completion
# load $HOME/.works.sh
# load $HOME/Dropbox/dotfiles/rails.bash
# source $HOME/.app.sh
# if [ -f $(brew --prefix)/etc/bash_completion ]; then
#     . $(brew --prefix)/etc/bash_completion
# fi

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

# export JUBATUS_HOME="`brew --prefix`/jubatus"
# export PATH="${JUBATUS_HOME}/bin:${PATH}"
# export LD_LIBRARY_PATH="${JUBATUS_HOME}/lib:${LD_LIBRARY_PATH}"
# export LDFLAGS="-L${JUBATUS_HOME}/lib ${LDFLAGS}"
# export CPLUS_INCLUDE_PATH="${JUBATUS_HOME}/include:${CPLUS_INCLUDE_PATH}"
# export PKG_CONFIG_PATH="${JUBATUS_HOME}/lib/pkgconfig:${PKG_CONFIG_PATH}"
