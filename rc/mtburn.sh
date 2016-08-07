alias M="cd $HOME/projects/mtburn"
alias server="ssh osdakira@bastion1.mtburn.jp"
bind_fs(){
  sshfs vagrant@127.0.0.1:/mtburn/mtburn ./mtburn -o IdentityFile=/Users/osada.akira/projects/vagrants/.vagrant/machines/default/virtualbox/private_key -p 2222  -o sftp_server='sudo su mtburn -c /usr/lib/sftp-server' -o idmap=user -o uid=$(id -u)
}
