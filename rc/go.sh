# alias G="cd ~/projects/go"
# export GOPATH=$HOME/projects/go_test
# export PATH=$PATH:$GOPATH/bin
# export GOENVGOROOT=$HOME/.goenvs
# export GOENVTARGET=`pwd`/.homebrew/Cellar/go/1.3.3/bin
# source $GOENVTARGET/goenvwrapper.sh
# export GOENVTARGET=$HOME/.goenv/
# export GOPATH="$HOME/.gopath"
# export PATH=$PATH:$GOPATH/bin

#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
load "$HOME/.gvm/bin/gvm-init.sh"
# source "/Users/osada/.gvm/bin/gvm-init.sh"
SBT_OPTS="-XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=256M"

export PATH=$PATH:$HOME/.homebrew/opt/go/libexec/bin
alias boot2docker='boot2docker --vm=boot2docker-vm-vboxfs'
export DOCKER_HOST=tcp://192.168.59.103:2375
alias dl='docker ps -l -q'
alias docker_rm="docker ps -a -q | xargs docker rm"
alias docker_rmi="docker images | grep none | awk '{print $3}' | xargs docker rmi"
