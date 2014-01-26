R(){
  killprog memcached
  killprog redis-server
  #killprog spork
  case `pwd` in
      *edo2*)
          E2
          ps aux| grep -v grep | grep  unicorn_rails | grep 8081 | awk '{print $2}' | xargs kill
          bundle exec unicorn_rails -p 8081 &
          ;;
      *)
          E
          ps aux| grep -v grep | grep  unicorn_rails | grep 8080 | awk '{print $2}' | xargs kill
          bundle exec unicorn_rails -p 8080 &
          ;;
  esac
  killprog node
  #spork &
  memcached &
  redis-server &
  cd app/scripts/
  node grunt c s watch
}

deploy() {
    deploy_imp sandbox ec2-54-249-158-75.ap-northeast-1.compute.amazonaws.com
}

deploy_4() {
    deploy_imp sandbox_4 ec2-54-248-2-206.ap-northeast-1.compute.amazonaws.com
}

deploy_imp(){
   expect -c "
   spawn cap $1 nginx:stop unicorn:stop deploy:update unicorn:start nginx:start -s branch="$(parse_git_branch)"
   expect \"deployed server : \[$2\]\"
   send \"\n\n\"
   expect \"branch or tag : \[$(parse_git_branch)\]\"
   send \"\n\n\"
   interact
   "
   notice "deploy"
}

s3() {
    rake assets:precompile FOG_DIRECTORY="edo-sandbox"
}
deploy_s3() {
    root=`pwd`
    rake assets:precompile FOG_DIRECTORY="edo-sandbox"
    echo $?
    cd $root
    git add public/assets/manifest.yml
    echo $?
    git commit -m "public/assets/manifest.yml"
    echo $?
    git push
    echo $?
    deploy
    echo $?
    rm public/assets
    echo $?
    git checkout public/assets/manifest.yml
    echo $?
    N "deploy with S3"
    echo $?
}
gcomasset() {
    git commit -m "public/assets/manifest.yml"
}

urestart(){
   expect -c "
   spawn cap sandbox unicorn:restart
   expect \"deployed server : \[ec2-54-249-158-75.ap-northeast-1.compute.amazonaws.com\]\"
   send \"\n\n\"
   interact
  "
}

alias routes="rake routes"

# export AWS_ACCESS_KEY_ID="AKIAJZBWK4XQM7KK3LPA"
# export AWS_SECRET_ACCESS_KEY="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"
# export FOG_DIRECTORY="edo-sandbox" # S3バケット名

alias gr="git checkout release/dmm"

alias rcmake="rake constants:make"
alias rjmake="rake json:make"
alias rjload="rake json:load"
alias rimake="rake images:make"
