[[ `which brew` ]] || curl -L https://github.com/Homebrew/homebrew/tarball/master | tar xz --strip 1 -C $HOME/.homebrew
export PATH=$HOME/.homebrew/bin:$PATH

[[ `which tmux` ]] || brew install tmux && brew install reattach-to-user-namespace
[[ `which hub` ]] || brew install hub

ln -s ~/Dropbox/dotfiles/.atom ~/.atom
ln -s ~/Dropbox/dotfiles/tmux.conf ~/.tmux.conf
