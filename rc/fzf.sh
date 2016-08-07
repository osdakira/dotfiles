# fd() {
#   local dir
#   dir=$(find ${1:-*} -path '*/\.*' -prune \
#                   -o -type d -print 2> /dev/null | fzf +m) &&
#   cd "$dir"
# }

# fkill() {
#   pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
#
#   if [ "x$pid" != "x" ]
#   then
#     kill -${1:-9} $pid
#   fi
# }

# fbr() {
#   local branches branch
#   branches=$(git branch --all | grep -v HEAD) &&
#   branch=$(echo "$branches" |
#            fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
#   git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
# }

# fs() {
#   local session
#   session=$(tmux list-sessions -F "#{session_name}" | \
#     fzf --query="$1" --select-1 --exit-0) &&
#   tmux switch-client -t "$session"
# }

# ftpane () {
#   local panes current_window target target_window target_pane
#   panes=$(tmux list-panes -s -F '#I:#P - #{pane_current_path} #{pane_current_command}')
#   current_window=$(tmux display-message  -p '#I')
#
#   target=$(echo "$panes" | fzf) || return
#
#   target_window=$(echo $target | awk 'BEGIN{FS=":|-"} {print$1}')
#   target_pane=$(echo $target | awk 'BEGIN{FS=":|-"} {print$2}' | cut -c 1)
#
#   if [[ $current_window -eq $target_window ]]; then
#     tmux select-pane -t ${target_window}.${target_pane}
#   else
#     tmux select-pane -t ${target_window}.${target_pane} &&
#     tmux select-window -t $target_window
#   fi
# }
