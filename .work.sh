##########
# workon #
##########

alias comgrep="./manage.py help 2>&1|grep "

alias tags="ctags -eR ."

#alias sqllog="tail -n 1000 -f /usr/local/var/mysql/osada-no-MacBook-Pro.log"
alias sqllog="tail -n 1000 -f /tmp/myquery.log"

alias L="sqllog"

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
    `basename "$VIRTUAL_ENV"`
    #killserversg
    # killall redis-server
    killall memcached
    killrunsever
    killttserver
    sleep 0.2
	runttserver &
    memcached &
    sleep 0.2
    # redis-server &
    runserver
    # sleep 0.5
    # tteditor &
}
alias R=resetserver

syncdb(){
    c="python manage.py syncdb --settings=${my_settings}"
    # c="python manage.py syncdb"
    echo $c;$c
}

loaddata(){
    G
    ./load.sh ${my_settings}
}

migrate(){
    #c="python manage.py migrate ${1} ${2} --settings=${my_settings}"
    c="python manage.py migrate ${1} ${2}"
    echo $c
    $c
}
rebuildapp(){
    python manage.py migrate  ${1} zero 
    rm -rf module/${1}/migrations/
    sinit  ${1}
    # python manage.py schemamigration ${1} --initial --settings=${my_settings}
    # python manage.py migrate ${1} --settings=${my_settings}
}

sinit(){
    python manage.py schemamigration ${1} --initial
    python manage.py migrate ${1} 
}

sauto(){
    python manage.py schemamigration ${1} --auto
    python manage.py migrate ${1} 
}

szero(){
    python manage.py migrate ${1} zero
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
    #G
    #P
    workonhook `basename "$VIRTUAL_ENV"`
    python manage.py dbshell
}
shell(){
    #G
    #P
    workonhook `basename "$VIRTUAL_ENV"`
    python manage.py shell_plus
}

alias update_cache_all="./manage.py update_cache_all;R"
alias UA="update_cache_all"

# ${ENV_NAME}(){
#     workon ${ENV_NAME}
#     cd projects/${ENV_NAME}/application
# }

greppy(){
        str=${1}
        shift
        grep -r --include=*.py $* ${str} . 
}

alias sqlstart="sudo /Library/StartupItems/MySQLCOM/MySQLCOM start"
alias sqlstop="sudo /Library/StartupItems/MySQLCOM/MySQLCOM stop"
