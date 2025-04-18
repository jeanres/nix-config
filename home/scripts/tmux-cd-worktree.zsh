
tmux-cd-worktree() {
  local dir="$PWD"
  local gitdir=""
  while [ "$dir" != "/" ]; do
    if [ -d "$dir/.bare" ]; then
      gitdir="$dir/.bare"
      break
    fi
    dir=$(dirname "$dir")
  done

  if [ -z "$gitdir" ]; then
    echo "No .bare directory found upward from current path." >&2
    return 1
  fi

  local worktree
  worktree=$(GIT_DIR="$gitdir" git worktree list | awk '{print $1}' | fzf --prompt="Select a worktree: ") || return
  [ -z "$worktree" ] && return

  local escaped_dir
  escaped_dir=$(printf %q "$worktree")

  local session
  session=$(tmux display-message -p '#S')

  # ✅ Now list all panes, filter by session name
  tmux list-panes -a -F '#{session_name}:#{window_index}.#{pane_index}' | grep "^$session:" | while read -r pane; do
    tmux send-keys -t "$pane" "cd $escaped_dir" C-m
  done
}
