gitdir=""
while [ "$dir" != "/" ]; do
  echo "Checking directory: $dir"
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

# Create a list of worktrees and use fzf for selection
worktree=$(GIT_DIR="$gitdir" git worktree list | awk '{print $1}' | fzf --prompt="Select a worktree: ") || exit 0
echo "Selected worktree: $worktree"
[ -z "$worktree" ] && exit 0

escaped_dir=$(printf %q "$worktree")
session=$(tmux display-message -p '#S')

echo "Session: $session"

# Open a new tmux window to run fzf interactively, ensuring we are in the correct environment
tmux split-window -v "bash -c 'echo \"Select worktree for session: $session\"; echo \"$escaped_dir\"; fzf --prompt=\"Select a worktree: \"'"

# List all panes and change directory in each one
tmux list-panes -a -F '#{session_name}:#{window_index}.#{pane_index}' | grep "^$session:" | while read -r pane; do
  tmux send-keys -t "$pane" "cd $escaped_dir" C-m
done
