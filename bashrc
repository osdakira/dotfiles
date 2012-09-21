export LOAD_BASHRC=1

PS1='\w\$ '

export PATH=/usr/local/mysql/bin:/opt/local/bin:/usr/local/bin:${PATH}

alias ls='ls -GFW'
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -la"

once_pushd(){
    if [ $1 ]; then
        target=$1
    else
        target=`pwd`
    fi
    # echo target ${target}

    a_dir=`dirs -l +1 2>/dev/null`
    if [ $? -eq 0 ]; then
        #echo ${target} ${a_dir}

        if [ ${target} != ${a_dir} ]; then
            pushd ${target}
        fi
    else
        pushd ${target}
    fi
}
#alias cd="once_pushd"
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

# virtualenv
source $HOME/.gitrc
export WORKON_HOME=$HOME/.virtualenvs 
source /usr/local/bin/virtualenvwrapper_bashrc
source $HOME/.work.sh
source $HOME/.app.sh

export PYTHONDONTWRITEBYTECODE=1
[[ -s "$HOME/.pythonbrew/etc/bashrc" ]] && source "$HOME/.pythonbrew/etc/bashrc"
#pybrew switch Python-2.7.3
#pybrew use Python-2.7.3

my_rename(){
    while read LINE
    do
        rename ${LINE} $*
    done
}

alias rm='rmtrash'
