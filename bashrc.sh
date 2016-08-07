add_path() {
  [[ -d $1 ]] && export PATH=$1:${PATH} && echo $1
}
load() {
  [[ -f $1 ]] && source $1 && echo $1
}

load $HOME/Dropbox/dotfiles/rc/tokens.sh
load $HOME/Dropbox/dotfiles/rc/basic.sh
load $HOME/Dropbox/dotfiles/rc/ruby.sh
load $HOME/Dropbox/dotfiles/rc/git.sh
load $HOME/Dropbox/dotfiles/git-completion.bash
# load $HOME/Dropbox/dotfiles/rc/perl.sh
load $HOME/Dropbox/dotfiles/rc/mtburn.sh
add_path $HOME/.cask/bin
