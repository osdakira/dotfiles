export GIT_MERGE_AUTOEDIT=no

alias ginit="cd ..; git submodule init; cd application"
alias gupdate="cd ..; git submodule update ; cd application"
alias gsubmodule="cd ..; git submodule; cd application"

alias gconf="git commit"
alias gcom="git commit -m"
alias gcoma="git commit --allow-empty -m"

alias gcln="git clean -d -f"

# alias gpul="git pull --rebase"
alias gpul="git pull"
alias grr="git rebase release"
alias grbr="grb release"

# gpul(){
#     git pull --rebase $* || (git branch --set-upstream-to=origin/`parse_git_branch` `parse_git_branch` && git pull --rebase $*)
# }
# alias gpul="git pull"
# alias gpulr="git pull --rebase --no-ff --prune"
alias gpl="gpul"
alias gpull="gpul"
alias gprune="gpul --prune"
alias gpush="git push"
alias gpuh="gpush"
alias gpsh="gpush"
alias gls="git log --stat"
alias glp="git log -p"
alias ggrep="git grep --line-number --show-function --color --heading --break"

gout() {
  if [ "$#" -eq 0 ]; then
    git checkout `git branch | grep -v pickles | peco | sed -e "s/\* //g" | awk "{print \$1}"`
  else
    git checkout $*
    # if [ "$?" -ne 0 ]; then
    #     echo "create branch ${*}"
    #     git checkout -b $*
    # fi
    git log --oneline -3
    git stash list
  fi
}

goutp(){
    git checkout -b $1 origin/$1
}

gbrclean(){
  [[ `parse_git_branch` =~ (master|release|development) ]] && git branch --merged | grep -v -E "\*|master$|release$|development$" | xargs git branch -d
}

gupstream(){
  git branch --set-upstream-to=origin/`parse_git_branch` `parse_git_branch`
}

alias gf="git fetch"
gbr() {
  if [ $# -eq 0 ]; then
    git branch | grep -v pickles
  else
    git branch $*
  fi
}
alias gmerge="git merge --no-ff"
#alias gmerge="git merge"
alias gmerg="gmerge"
alias gmergs="git merge --squash"


alias gstash="git stash"
alias gstashs="gstash save"
alias gstashl="gstash list"
alias gstashp="gstash pop"

alias grb="git rebase --no-ff"
# alias gr="git rebase --no-ff"
alias grbm="git rebase master"

alias gmgm="gmerg master"
# alias gmgr="gmerge release"
# alias gmgd="gmerge develop"

# alias gr="gout release"
alias gm="gout master"
alias gs="gout staging"
# alias gd="gout development"
# alias go="gout osada"
# alias gd="gout develop"
# alias gpullup="git pull upstream master"

# pullrequest(){
#   git checkout master
#   git pull upstream master
#   git push origin master
#   git checkout -
#   git rebase origin master
# }

alias grbc="git rebase --continue"
alias A="git add"
alias S="git status; git stash list"
alias D="git diff"
alias DW="git diff --word-diff=plain"
alias DC="git diff --cached"
alias gamend="git commit --amend"

alias gb="git browse"

#alias gtree="git log --graph --pretty=oneline --decorate --date=short --abbrev-commit --branches"
alias gtree="git log --graph --pretty=oneline --date=short --abbrev-commit --branches"

# gtrack(){
#     git branch --set-upstream-to=origin/$1 $1
# }

### Display git branch ###

c_cyan=`tput setaf 6`
c_red=`tput setaf 1`
c_green=`tput setaf 2`
c_sgr0=`tput sgr0`

parse_git_status(){
    local GIT_STATUS=`git status 2>/dev/null`
    local GIT_STASH=`git stash list  2>/dev/null`
    if [[ $GIT_STATUS != "" ]] ; then
        local REFS=$(git symbolic-ref HEAD 2>/dev/null)
        #local STAT_COLOR="\[\e[1;32m\]"
        local STAT_COLOR=$c_green
        local REFS="${REFS#refs/heads/}"
        if [[ `echo $GIT_STATUS | grep "modified:"` != "" ]] ; then
            STAT_COLOR="\[\e[1;31m\]"
            REFS="${REFS}\[\e[0m\] \[\e[1;35m\]modified\[\e[0m\]"
        fi
        if [[ `echo $GIT_STATUS | grep "ahead of"` != "" ]] ; then
            STAT_COLOR="\[\e[1;31m\]"
            REFS="${REFS}\[\e[0m\] \[\e[1;36m\]not pushed\[\e[0m\]"
        fi
        if [[ `echo $GIT_STATUS | grep "modified:"` != "" ]] ; then
            STAT_COLOR="\[\e[1;31m\]"
            REFS="${REFS}\[\e[0m\] \[\e[1;35m\]modified\[\e[0m\]"
        fi
        if [[ `echo $GIT_STASH` != "" ]] ; then
            STAT_COLOR="\[\e[1;31m\]"
            REFS="${REFS}\[\e[0m\] \[\e[1;35m\]modified\[\e[0m\]"
        fi
        echo -e "${STAT_COLOR}${REFS}"

    fi
}

branch_color (){
        if git rev-parse --git-dir >/dev/null 2>&1
        then
                color=""
                if git diff --quiet 2>/dev/null >&2
                then
                        color="${c_green}"
                else
                        color=${c_red}
                fi
        else
                return 0
        fi
        echo -ne $color
}

parse_git_branch(){
  # git branch 2>/dev/null で、git 外の場合を無視
  # sed -n は、sed デフォルト挙動の、標準出力への出力を停止。
  # '/^\*/s/^\* //p' は、 `/^\*/` で、* にマッチした行に対して、`s/^\* //` で、削除し、`p` で、標準出力に出力する。
  # echo -n は、改行をつけない
  # echo -e は、エスケープオプションを解釈する
  echo -ne $(git branch 2>/dev/null | sed -n '/^\*/s/^\* //p')
}
check_sync(){
        [[ `git diff --numstat origin/$(parse_git_branch)..HEAD 2>/dev/null` != "" ]] && echo -ne " (\033[33mno_sync\033[0m)"
}

parse_git_stash(){
        [[ `git stash list 2>/dev/null`  != "" ]] && echo -ne " "${c_cyan}stash${c_sgr0}
}

PS1='[\[$(branch_color)\]$(parse_git_branch)\[${c_sgr0}\]$(parse_git_stash)$(check_sync)]\[${c_red}\]\w\[${c_sgr0}\]: '
# PS1='[$(check_sync) \w]: '

#PS1='[\[$(branch_color)\]$(parse_git_branch)\[${c_sgr0}\]] \u@\[${c_red}\]\w\[${sgr0_c}\]: '
#PS1='[\[$(branch_color)\]$(parse_git_status)\[${c_sgr0}\]] \[${c_red}\]\w\[${c_sgr0}\]: '

function prompt_command {
    local RETURN_CODE="$?"
    local ASCII_RESET="\[\e[0m\]"
    local ASCII_BOLD="\[\e[1m\]"
    local USER_COLOR="\[\e[1;33m\]" # yellow
    local PROMPT_COLOR="\[\e[1;32m\]"
    if [[ ${EUID} == 0 ]] ; then
        PROMPT_COLOR="\[\e[1;31m\]"
    fi
    local HOST_COLOR="\[\e[1;32m\]" # green
    local DATE_COLOR="\[\e[1;31m\]" # red
    local TIME_COLOR="\[\e[1;34m\]" # purple
    local DATE_STRING="\$(date +%m/%d)"
    local TIME_STRING="\$(date +%H:%M:%S)"
    local CYAN_COLOR="\[\e[1;36m\]"
    local PINK_COLOR="\[\e[1;35m\]"

    local PROMPT_PREFIX="$PROMPT_COLOR"
    if [[ $RETURN_CODE != 0 ]] ; then
        PROMPT_PREFIX="$DATE_COLOR$RETURN_CODE$ASCII_RESET " # do nothing
    fi
    local GIT_STATUS=`git status 2>/dev/null`
    if [[ $GIT_STATUS != "" ]] ; then
        local REFS=$(git symbolic-ref HEAD 2>/dev/null)
        REFS="${REFS#refs/heads/}"
        if [[ `echo $GIT_STATUS | grep "modified:"` != "" ]] ; then
            REFS="$REFS$ASCII_RESET ${PINK_COLOR}modified"
        fi
        if [[ `echo $GIT_STATUS | grep "ahead of"` != "" ]] ; then
            REFS="$REFS$ASCII_RESET ${CYAN_COLOR}not pushed"
        fi
        PROMPT_PREFIX="$PROMPT_PREFIX$USER_COLOR$REFS$ASCII_RESET"
    fi

    #PS1="$ASCII_BOLD[$USER_COLOR\u $HOST_COLOR\h $DATE_COLOR$DATE_STRING $TIME_COLOR$TIME_STRING $PROMPT_PREFIX$ASCII_RESET\w$ASCII_BOLD]$ASCII_RESET\n$PROMPT_COLOR\\\$$ASCII_RESET "
    #PS1="$ASCII_BOLD[$PROMPT_PREFIX$ASCII_RESET]\w:"
    #PS1="(`basename \"$VIRTUAL_ENV\"`)$PS1"
    echo -e "$ASCII_BOLD[$PROMPT_PREFIX$ASCII_RESET]"
}
#export PROMPT_COMMAND=prompt_command

# function _git_not_pushed()
# {
#     if [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ]; then
#     head="$(git rev-parse HEAD)"
#     for x in $(git rev-parse --remotes)
#     do
#       if [ "$head" = "$x" ]; then
#         return 0
#       fi
#     done
#     echo "#unpushed"
#   fi
#   return 0
# }

hpush(){
    git push heroku ${1:-master}
}

# goutf(){
#   if [[ $2 ]] ; then
#     branch=$2; opt=$1
#   else
#     branch=$1; opt=""
#   fi

#   git checkout ${opt} feature/${branch}
# }

gpicles () {
  branch=`git branch | peco | sed -e "s/\* //g" | awk "{print \$1}"`
  echo "git branch -m ${branch} ${branch//\//\/pickles/}"
  # git branch -m ${branch} ${branch//\//\/pickles/}
}
