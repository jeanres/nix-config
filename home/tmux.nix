{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    baseIndex = 1;

    extraConfig = ''
      set -g escape-time 0
      set -g default-terminal "tmux-256color"
      set-option -ga terminal-overrides ",xterm-256color:Tc"
      set-option -g focus-events on
      set -g status-position top

      bind-key g display-popup -E -w 80% -h 80% -S "fg=#{@thm_overlay_0}" lazygit
      bind-key s display-popup -E -w 80% -h 80% -S "fg=#{@thm_overlay_0}" "tmux list-sessions -F '#S' | fzf | xargs tmux switch-client -t"

      bind r source-file ~/.config/tmux/tmux.conf \; display-message "source-file reloaded"

      set -g status-style "bg=#{@thm_bg}"
      set -g status-justify "absolute-centre"

      # pane border look and feel
      setw -g pane-border-status top
      setw -g pane-border-format ""
      setw -g pane-active-border-style "bg=#{@thm_bg},fg=#{@thm_overlay_0}"
      setw -g pane-border-style "bg=#{@thm_bg},fg=#{@thm_surface_0}"
      setw -g pane-border-lines single

      # window look and feel
      set -wg automatic-rename on
      set -g automatic-rename-format "Window"

      set-window-option -g mode-keys vi

      set -g status-interval 5
      set -g automatic-rename on
      set -g renumber-windows on
      set -g automatic-rename-format '#{pane_current_command}'
      set -g history-limit 50000

      bind  c  new-window      -c "#{pane_current_path}"
      bind  %  split-window -h -c "#{pane_current_path}"
      bind '"' split-window -v -c "#{pane_current_path}"
    '';
    plugins = with pkgs; [
      tmuxPlugins.vim-tmux-navigator
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-capture-pane-contents 'on'
        '';
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '60' # minutes
        '';
      }
      {
        plugin = tmuxPlugins.catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavor "latte"
          set -g @catppuccin_status_background "none"
          set -g @catppuccin_window_status_style "none"
          set -g @catppuccin_pane_status_enabled "off"
          set -g @catppuccin_pane_border_status "off"

          # Configure Online
          set -g @online_icon "ok"
          set -g @offline_icon "nok"

          # status left look and feel
          set -g status-left-length 100
          set -g status-left ""
          set -ga status-left "#{?client_prefix,#{#[bg=#{@thm_red},fg=#{@thm_bg},bold]  #S },#{#[bg=#{@thm_bg},fg=#{@thm_green}]  #S }}"
          set -ga status-left "#[bg=#{@thm_bg},fg=#{@thm_overlay_0},none]│"
          set -ga status-left "#[bg=#{@thm_bg},fg=#{@thm_maroon}]  #{pane_current_command} "
          set -ga status-left "#[bg=#{@thm_bg},fg=#{@thm_overlay_0},none]│"
          set -ga status-left "#[bg=#{@thm_bg},fg=#{@thm_blue}]  #{=/-32/...:#{s|$USER|~|:#{b:pane_current_path}}} "
          set -ga status-left "#[bg=#{@thm_bg},fg=#{@thm_overlay_0},none]#{?window_zoomed_flag,│,}"
          set -ga status-left "#[bg=#{@thm_bg},fg=#{@thm_yellow}]#{?window_zoomed_flag,  zoom ,}"

          # status right look and feel
          set -g status-right-length 100
          set -g status-right ""
          set -ga status-right "#{?#{e|>=:10,#{battery_percentage}},#{#[bg=#{@thm_red},fg=#{@thm_bg}]},#{#[bg=#{@thm_bg},fg=#{@thm_pink}]}} #{battery_icon} #{battery_percentage} "
          set -ga status-right "#[bg=#{@thm_bg},fg=#{@thm_overlay_0}, none]│"
          set -ga status-right "#[bg=#{@thm_bg}]#{?#{==:#{online_status},ok},#[fg=#{@thm_mauve}] 󰖩 on ,#[fg=#{@thm_red},bold]#[reverse] 󰖪 off }"
          set -ga status-right "#[bg=#{@thm_bg},fg=#{@thm_overlay_0}, none]│"
          set -ga status-right "#[bg=#{@thm_bg},fg=#{@thm_blue}] 󰭦 %Y-%m-%d 󰅐 %H:%M "

          set -g window-status-format " #I#{?#{!=:#{window_name},Window},: #W,} "
          set -g window-status-style "bg=#{@thm_bg},fg=#{@thm_rosewater}"
          set -g window-status-last-style "bg=#{@thm_bg},fg=#{@thm_peach}"
          set -g window-status-activity-style "bg=#{@thm_red},fg=#{@thm_bg}"
          set -g window-status-bell-style "bg=#{@thm_red},fg=#{@thm_bg},bold"
          set -gF window-status-separator "#[bg=#{@thm_bg},fg=#{@thm_overlay_0}]│"

          set -g window-status-current-format " #I#{?#{!=:#{window_name},Window},: #W,} "
          set -g window-status-current-style "fg=#{@thm_green},bold"
        '';
      }
      tmuxPlugins.battery
      tmuxPlugins.online-status
      tmuxPlugins.tmux-toggle-popup
    ];
  };
}
