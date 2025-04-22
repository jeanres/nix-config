#!/usr/bin/env bash

dir="$PWD"
gitdir=""
while [ "$dir" != "/" ]; do
  if [ -d "$dir/.bare" ]; then
    gitdir="$dir/.bare"
    break
  fi
  dir=$(dirname "$dir")
done

if [ -z "$gitdir" ]; then
  echo "No .bare directory found upward from current path." >&2
  exit 1
fi

worktree=$(GIT_DIR="$gitdir" git worktree list | awk '{print $1}' | fzf --prompt="Select a worktree: ") || exit 0
[ -z "$worktree" ] && exit 0

escaped_dir=$(printf %q "$worktree")
session=$(tmux display-message -p '#S')

tmux split-window -v "bash -c 'echo \"Select worktree for session: $session\"; echo \"$escaped_dir\"; fzf --prompt=\"Select a worktree: \"'"

tmux list-panes -a -F '#{session_name}:#{window_index}.#{pane_index}' | grep "^$session:" | while read -r pane; do
  tmux send-keys -t "$pane" "cd $escaped_dir" C-m
done
