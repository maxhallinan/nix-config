{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    initExtra = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"
    '';
    oh-my-zsh = {
      enable = true;
      plugins = ["git" "tmux" "z"];
    };
  };
}
