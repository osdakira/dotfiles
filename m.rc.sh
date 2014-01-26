R() {
    # killprog redis-server
    # killprog resque
    # killprog gurad

    # M
    ps aux | grep ruby | grep guard | grep -v grep || bundle exec guard &
    ps aux | grep redis-server | grep -v grep || redis-server ~/.redis.conf &
    ps aux | grep resque | grep -v grep || bundle exec rake resque:work QUEUE='*' &

    # ps aux| grep -v grep | grep unicorn_rails | grep 8080 | awk '{print $2}' | xargs kill
    # bundle exec unicorn_rails -p 8080 &
    # bundle exec rake resque:work QUEUE='*' &
    # ps u | grep memcached | grep -v grep || memcached -vvv

    # ps aux | grep "rails s" | grep -v grep | awk '{print $2}' | xargs kill -9
    # bundle exec rails s
}

reset_db() {
    bundle exec spring rake db:reset # 初期化。データベース構造を変えた場合
    bundle exec spring rake db:import_dummy_data_all  # テストデータの挿入
    bundle exec spring rake db:test:prepare
    N "reset_db"
}

b_cap(){
    bundle exec cap $1 $2 -s branch=$(parse_git_branch)
}
b_migrate(){
    b_cap $1 migrate
}
b_deploy(){
    b_cap $1 deploy
}

alias b_deploy_st4="b_deploy staging_4"

unalias gr
gr() {
    git checkout `git branch | grep -v "*" | grep " .release"`
}

parallel_test() {
    # bundle exec spring rake parallel:prepare
    # bundle exec spring rake parallel:spec
    bundle exec rake parallel:prepare
    bundle exec rake parallel:spec
    notice "parallel_test"
}
parallel_test_create() {
    bundle exec rake parallel:create
}

srspec() {
    echo "bundle exec spring rspec $*"
    bundle exec spring rspec $*
    notice "rspec"
}

alias srake="bundle exec spring rake"
alias srails="bundle exec spring rails"

alias sstop="bundle exec spring stop"
alias cap="bundle exec cap"
alias rake="bundle exec rake"
alias load_sql="cat /Users/osada/tmp/sanitized_mysql_table_data.sql | be rails db"
alias precompile="RAILS_ENV=development RAILS_GROUPS=assets bundle exec rake assets:precompile"

alias reset_gem='gem list | grep -v "rdoc" | grep -v "test-unit" | grep -v "rake" | grep -v "psych" | grep -v "io-console"  | grep -v "bigdecimal" | grep -v "json" | grep -v "minitest" | xargs gem uninstall -a'
