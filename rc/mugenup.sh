source $HOME/Dropbox/dotfiles/m.rc.sh
source $HOME/Dropbox/dotfiles/m.ignore.sh

# c_login(){
#     set -x
#     # set -eux
#     ip=`grep server $1 | cut -d "'" -f 2`
#     pem=`grep pem $1 | perl -pe '$_ =~ s/.*?(\w+\.pem).*/\1/'`
#     ssh -i $HOME/.ssh/${pem} ubuntu@${ip}
#     # set +eux
#     set +x
# }

# alias cls="c_login config/deploy/staging.rb"
# alias clp="c_login config/deploy/production.rb"
export CONFIG_JSON_PATH=$HOME/config.json
