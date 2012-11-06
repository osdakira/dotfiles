alias seleniumfox="open -a Firefox --args -p SeleniumUser"
alias size="sips -g all"
alias ql='qlmanage -p "$@" >& /dev/null'
tags(){
    # ctags -ueR `pwd`
    find `pwd` -name "*.py" -print | etags -a -
}

alias sqllog="tail -n 1000 -f /tmp/myquery.log"

migrate(){
    all_dbs eventmodule migrate --no-initial-data $*
}

revert_app(){
    all_dbs eventmodule revert_app $*
}

all_dbs(){
    DATABASE_ALIAS_NAMES=`python -c "from settings.osada import DATABASES;print ' '.join([db for db in DATABASES if db != 'read'])"`
    for i in ${DATABASE_ALIAS_NAMES}
    do
        echo ./manage.py ${*} --database=${i} &
        ./manage.py ${*} --database=${i} &
    done
    wait
}

workonhook(){
    workon $1
    cd $HOME/projects/$1/application
}

killservers(){
    killall python
    killall ttserver
    killall memcached
}

killserver(){
     for pid in $*
     do
         kill ${pid}
     done
}

killrunsever(){
    killserver `ps x | grep -v grep | grep 'python' | grep ${server_port} | awk '{print $1}'`
}
killttserver(){
    killserver `ps x | grep -v grep | grep 'ttserver' | grep ${server_port} | awk '{print $1}'`
}

resetserver(){
    workonhook `basename "$VIRTUAL_ENV"`
    killall redis-server
    killall memcached
    killrunsever
    sleep 0.2

    memcached &
    if [ -f ${VIRTUAL_ENV}/redis.conf ]; then
        redis-server ${VIRTUAL_ENV}/redis.conf &
    else
        redis-server ${HOME}/.redis.conf &
    fi
    # python ./manage.py update_cache_all &
    ./manage.py update_gacha_deck &
    python manage.py runserver_plus 0.0.0.0:${server_port}
}
alias R=resetserver
alias U="./mange.py update_cache_all"

rebuildapp(){
    python manage.py migrate  ${1} zero
    rm -rf module/${1}/migrations/
    sinit  ${1}
    # python manage.py schemamigration ${1} --initial --settings=${my_settings}
    # python manage.py migrate ${1} --settings=${my_settings}
}

sinit(){
    python manage.py eventmodule schemamigration ${1} --initial
    python manage.py eventmodule migrate ${1}
}

sauto(){
    python manage.py eventmodule schemamigration ${1} --auto
    python manage.py eventmodule migrate ${1}
}

szero(){
    python manage.py eventmodule migrate ${1} zero
}

createdb(){
    #echo 'CREATE DATABASE '${1}' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;' |mysql -uroot -p${db_pass}
    echo 'CREATE DATABASE '${1}' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;' |mysql -uroot
}

reset_db(){
    # echo 'DROP DATABASE '${1}'' |mysql -uroot -p${db_pass}
    echo 'DROP DATABASE '${1}'' |mysql -uroot
    createdb ${1}
}

reset_migrations(){
    find module -name "migrations" -exec rm -rf {} +
    ./manage.py init_migrations
}

###############
# TokyoTyrant #
###############
alias tteditor="python $HOME/projects/tt-editor/tt-editor.py"
tcr(){
    tcrmgr ${1} -port ${tt_port} localhost ${2}
}
runttserver(){
    ttserver -port ${tt_port} ~/mytmp/`basename "$VIRTUAL_ENV"`.tch
}

########
# Misc #
########
dbshell(){
    workonhook `basename "$VIRTUAL_ENV"`
    python manage.py dbshell
}
shell(){
    workonhook `basename "$VIRTUAL_ENV"`
    python manage.py shell_plus
}

# alias update_cache_all="./manage.py update_cache_all;R"
# alias UA="update_cache_all"

alias sqlstart="sudo /Library/StartupItems/MySQLCOM/MySQLCOM start"
alias sqlstop="sudo /Library/StartupItems/MySQLCOM/MySQLCOM stop"

# resetserver(){
#     cd `basename "$VIRTUAL_ENV"`
#     # killservers
#     # killall redis-server
#     killall memcached
#     killall python
#     #killall ttserver
#     # killrunsever
#     # killttserver
#     # sleep 0.2
#     #runttserver &
#     memcached &
#     sleep 0.2
#     # redis-server &
#     runserver
#     # sleep 0.5
#     # tteditor &
#}
#alias runserver="python manage.py runserver 0.0.0.0:${server_port}"
