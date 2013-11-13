M() {
    cd $HOME/projects/mugenup/workstation
}

R() {
    # killprog redis-server
    # killprog resque
    # killprog gurad

    M

    ps aux | grep redis-server | grep -v grep || redis-server &
    ps aux | grep resque | grep -v grep || bundle exec rake resque:work QUEUE='*' &

    # ps aux| grep -v grep | grep unicorn_rails | grep 8080 | awk '{print $2}' | xargs kill
    # bundle exec unicorn_rails -p 8080 &
    # bundle exec rake resque:work QUEUE='*' &
    # ps u | grep memcached | grep -v grep || memcached -vvv

    ps aux | grep -v grep | grep "rails s" | awk '{print $2}' | xargs kill -9
    bundle exec rails s

    # bundle exec guard
    # ps aux | grep ruby | grep guard | grep -v grep || bundle exec guard &
}

reset_db() {
    bundle exec rake db:reset # 初期化。データベース構造を変えた場合
    # bundle exec rake db:migrate # テーブル作成
    # bundle exec rake db:seed # シードデータの挿入
    bundle exec rake db:import_dummy_data_all  # テストデータの挿入
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
    git checkout `git branch | grep -v "*" | grep release`
}

parallel_test() {
    bundle exec rake parallel:prepare
    bundle exec rake parallel:spec
}

rspec() {
    bundle exec rspec $*
    notice "rspec"
}
alias cap="bundle exec cap"
alias rake="bundle exec rake"
