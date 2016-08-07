PS1='\w\$ '
export EDITOR=vim
export LOAD_BASHRC=1
export CLICOLOR=1
# export LSCOLORS=DxGxcxdxCxegedabagacad
export LSCOLORS=DxDx
export HISTSIZE=9999
export HISTTIMEFORMAT='%y/%m/%d %H:%M:%S '
export HISTIGNORE=ls
export HISTCONTROL=ignoreboth
export MAIL_SEND=false

# 指定したオプションをONにできる。
shopt -u histappend
# shopt -s autocd # ディレクトリ名のみを入力したとき、 cdの引数に指定されたものとして扱う。
shopt -s cdspell # 本来移動したかったであろうディレクトリにちゃんとcdしてくれる。
shopt -s extglob # さらに強力なワイルドカードの表現が使えるようになる。
# shopt -s globstar # ** というワイルドカードが使われたとき、 該当ディレクトリ以下の サブディレクトリ、ファイル全てに再帰的にマッチする。

alias ls='ls -GFW'
alias ll="ls -lh"
alias la="ls -a"
# alias cd="pushd"
# alias pd="popd"
alias less="less -SRn"
alias grep="grep --color=auto"
alias rm='rmtrash'
alias size="sips -g all"
alias ssh_add_month="ssh-add -t 2592000 ~/.ssh/id_rsa"
alias today="date '+%Y%m%d'"
# alias ql='qlmanage -p "$@" >& /dev/null'
# alias sqllog="sudo tail -n 1000 -f /tmp/myquery.log"
# alias seleniumfox="open -a Firefox --args -p SeleniumUser"
# alias tmux=~/.mybin/tmuxx.sh
# alias lessF="less +F -Rf"

add_path $HOME/.homebrew/bin
export BREW_HOME=$(brew --prefix)
export PATH=$BREW_HOME/bin:$PATH
export LD_LIBRARY_PATH=$BREW_HOME/opt/openssl/lib:$LD_LIBRARY_PATH
export CPATH=$BREW_HOME/opt/openssl/include:$LD_LIBRARY_PATH
export PATH=$PATH:$BREW_HOME/share/git-core/contrib/diff-highlight

alias javac="javac -J-Dfile.encoding=UTF8"
alias unrepr="python -c \"import sys; [ sys.stdout.write('\t'.join( [ (s.startswith('u') and eval(s) or s) for s in line.split('\t') ])) for line in sys.stdin]\""

killprog(){
  #ps aux | grep -v grep | grep $1 | awk '{print $2}' | xargs kill
    ps aux | grep -v grep | grep $1 | awk '{print $2}' | xargs kill -9
}

## eval "$(direnv hook bash)"
