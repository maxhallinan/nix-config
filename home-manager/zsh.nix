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
    sessionVariables = {
      EDITOR = "nvim";
    };
    shellAliases = {
      mwt = "make generate-web-types pathToFrontendRepo=/Users/maxhallinan/Mercury/mercury-web-frontend";
    };
  };
}
