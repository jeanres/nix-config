{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    baseIndex = 1;

    extraConfig = ''
      set-option -g status-position top
      set -g status-interval 5
      set -g automatic-rename on
      set -g automatic-rename-format '#{pane_current_command}'
      '';
    plugins = with pkgs; [
      tmuxPlugins.vim-tmux-navigator
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-vim 'session'
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
    ];
  };
}
