{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      tmux-colors-solarized
    ];
    extraConfig = ''
      set -g default-terminal "screen-256color"
      set-option -g allow-rename off

      # Change to 'C-b'
      unbind C-b
      set-option -g prefix C-a
      bind-key C-b send-prefix

      # Create vertical pane
      # `prefix |`
      bind - split-window -v
      unbind %

      # Create horizontal pane
      # `prefix -`
      bind | split-window -h
      unbind '"'

      # Resize panes
      bind = resize-pane -D
      bind + resize-pane -U

      # switch panes using hjkl
      # left: `prefix h`
      # down: `prefix j`
      # up: `prefix k`
      # right: `prefix l`
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      set -g @colors-solarized 'dark'
    '';
  };
}
