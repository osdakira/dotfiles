RR() {
    # killprog redis-server
    # killprog resque
    # killprog gurad

    # M
    # ps aux | grep ruby | grep guard | grep -v grep || bundle exec guard &
    # ps aux | grep resque | grep -v grep || bundle exec rake resque:work QUEUE='*' &

    set -x

    if [[ -f "config/webpack.config.js" ]]; then
      ./node_modules/.bin/webpack --progress --colors --watch --config config/webpack.config.js
    fi

    # killall "foreman: master"
    ps aux | grep redis-server | grep -v grep || redis-server ~/.redis.conf &

    if [[ `pwd` =~ "workstation" ]]; then
        killprog resque
        bundle exec rake resque:work QUEUE='*' >> log/worker-1.log 2>&1 &
        bundle exec rake resque:scheduler >> log/scheduler-1.log 2>&1 &
    fi

    if [[ "bin/sidekiq" ]]; then
        bin/sidekiqctl stop tmp/pids/sidekiq.pid
        # bin/sidekiqctl stop tmp/pids/sidekiq_batch.pid
        bin/sidekiq -C config/sidekiq.yml &
        # bin/sidekiq -C config/sidekiq_batch.yml &
    fi

    # be foreman start &
    # ps aux| grep -v grep | grep unicorn_rails | grep 8080 | awk '{print $2}' | xargs kill
    # bundle exec unicorn_rails -p 8080 &
    # bundle exec rake resque:work QUEUE='*' &
    # ps u | grep memcached | grep -v grep || memcached -vvv

    # ps aux | grep "rails s" | grep -v grep | awk '{print $2}' | xargs kill -9
    # bundle exec rails s
    set +x
}

# reset_db() {
#     bundle exec spring rake db:reset # 初期化。データベース構造を変えた場合
#     bundle exec spring rake db:import_dummy_data_all  # テストデータの挿入
#     bundle exec spring rake db:test:prepare
#     N "reset_db"
# }

b_cap(){
    bundle exec cap $1 $2 -s branch=$(parse_git_branch)
}
b_migrate(){
    b_cap $1 migrate
}
b_deploy(){
    b_cap $1 deploy
}

s_deploy(){
    b_deploy staging deploy
}

# unalias gr
# gr() {
#     git checkout `git branch | grep -v "*" | grep " .release"`
# }
alias gr="git checkout release"

parallel_prepare(){
    echo "RAILS_ENV=test bundle exec bin/rake parallel:prepare"
    RAILS_ENV=test bundle exec bin/rake parallel:prepare
}
parallel_test() {
    echo "RAILS_ENV=test bundle exec bin/rake parallel:spec"
    RAILS_ENV=test bundle exec bin/rake parallel:spec
    notice "parallel_test"
}
parallel_test_with_prepare() {
    parallel_prepare
    parallel_test
}
parallel_test_create() {
    echo "RAILS_ENV=test bundle exec bin/rake parallel:create"
    RAILS_ENV=test bundle exec bin/rake parallel:create
}
srspec() {
    echo "bundle exec bin/rspec $*"
    bundle exec bin/rspec $*
    notice "rspec"
}

srake(){
    [[ "bin/rake" ]] && bin/rake $*
    bundle exec spring rake $*
}
srails(){
    [[ "bin/rails" ]] && bin/rails $*
    bundle exec spring rails $*
}

alias sstop="bundle exec spring stop"
alias cap="bundle exec cap"
alias rake="bundle exec rake"
alias load_sql="cat /Users/osada/tmp/sanitized_mysql_table_data.sql | be rails db"
alias precompile="RAILS_ENV=development RAILS_GROUPS=assets bundle exec rake assets:precompile"

alias reset_gem='gem list | grep -v "rdoc" | grep -v "test-unit" | grep -v "rake" | grep -v "psych" | grep -v "io-console"  | grep -v "bigdecimal" | grep -v "json" | grep -v "minitest" | xargs gem uninstall -a'

tree(){
  find . -print 2>/dev/null | awk '!/\.$/ { \
    for (i=1; i<NF; i++) { \
        printf("%4s", "|") \
    } \
    print "-- "$NF \
}' FS='/'
}

parallel_retry(){
    ruby -ne 'puts $1 if /(?<=rspec )([\.\/:\w]+)/' tmp/failing_specs.log | xargs bundle exec bin/rspec
}

alias cs4p="b_cap staging_4 precompile"
alias cs4d="b_cap staging_4 deploy"
alias cs4dp="cap staging_4 b_deploy precompile"
alias cs4fp="b_cap staging_4 full_deploy precompile"
alias cs4r="cap staging_4 deploy:restart"
alias cs4s="cap staging_4 deploy:start"
alias cs4log="cap staging_4 log"
alias cs4l="cap staging_4 login"
alias csl="cap staging_1 login"
alias g4="gout feature/staging_4"
alias cpl0="cap production login 0"
alias cpl1="cap production login 1"
alias cbl="cap batch login"

b_deploy_with(){
    this_branch=$(git branch 2>/dev/null | sed -n '/^\*/s/^\* //p')
    target_staging=$1
    target_branch="feature/"$1
    if git diff --quiet 2>/dev/null >&2
    then
        git checkout $target_branch
        git merge $this_branch && \
            git push && \
            git checkout $this_branch && \
            cap $target_staging deploy -s branch=$target_branch
    fi
}
alias b_deploy_with_4="b_deploy_with staging_4"
# alias load_by_sql="be rails db < `ls -1tr ~/tmp/mysql_dump* | tail -n 1`"
alias bdw4="b_deploy_with staging_4"

alias recruit="echo export RAILS_AS=recruit > .powenv && touch tmp/restart.txt"
alias station="echo export RAILS_AS=station > .powenv && touch tmp/restart.txt"
alias csd="cap staging deploy"
alias cslog="cap staging log"
alias csr="cap staging unicorn:restart"
