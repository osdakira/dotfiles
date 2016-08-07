export AUTODOC=1
export RBENV_ROOT=$HOME/.homebrew/var/rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
# [[ -d $HOME/.rbenv/bin ]] && export PATH=$HOME/.rbenv/bin:$PATH; eval "$(rbenv init -)"

alias be="bundle exec"
# alias rdm="be bin/rake db:migrate"
# alias rdreset="be bin/rake db:reset && rdtp && notice 'rdreset'"
# alias rdmreset="be bin/rake db:migrate:reset && rdtp && notice 'rdreset'"
# alias rdrecreate="bin/rake db:migrate:reset db:seed && notice 'rdreset'"
# alias rdmresetdev="bin/rake db:migrate:reset"
# alias rdmrt="RAILS_ENV=test bin/rake db:migrate:reset"
# alias rdmreset="rdmresetdev && rdmresettest && notice 'rdreset'"
# alias gcomrdm="git commit -m 'rake db:migrate'"
# alias rgm="be bin/rails g migration"
# alias con="be rails c"
# alias scon="be bin/rails c"
# alias db="be rails db"
# alias sdb="be bin/rails db"
# alias rdtp="RAILS_ENV=test be bin/rake db:setup"
# alias powrestart="powify server restart"
# alias powb="powify browse"
# alias powr="powify restart"
# alias powl="powify server logs"
# export PARALLEL_TESTS_EXECUTABLE="bundle exec rspec"
# alias rseed="bin/rake db:seed"
# alias rmreset="bin/rake db:migrate:reset"
# alias tdl="tail -n 1000 -f log/development.log"
# alias tslog='tail -f log/sidekiq.log'
# alias powlog='tail -n 1000 -f ~/Library/Logs/Pow/apps/manon.log'

tlog(){
  M
  tail -n 1000 -f log/development.log
}
tlogt() {
    tail -n 1000 -f log/test.log | grep -v TRUNCATE
}

rakespec(){
  SPEC_OPTS=""
  [[ `ps | grep -v grep | grep spork` ]] && SPEC_OPTS="SPEC_OPTS=--drb"
  bundle exec rake spec ${SPEC_OPTS}
  notice "rspec"
}

# f_deploy(){
#     previous=`parse_git_branch`
#     gom ; gmerg ${previous}; gpush; cmd &
#     gout -
# }

#rspec(){
#  SPEC_OPTS=""
#  [[ `ps | grep -v grep | grep spork` ]] && SPEC_OPTS="--drb"
#  bundle exec rspec ${SPEC_OPTS} $*
#  notice "rspec"
#}

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

installrbenv(){
  git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
  git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
}

# [ -f ~/Dropbox/dotfiles/.bundler-exec.sh ] && source ~/.bundler-exec.sh
# load $HOME/.bundler-exec.sh
