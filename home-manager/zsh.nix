{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    initExtra = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"
      export PATH=$N_PREFIX/bin:$PATH

      recreatedb(){
        dropdb $1
        createdb $1
      }
    '';
    oh-my-zsh = {
      enable = true;
      plugins = ["git" "tmux" "z"];
    };
    sessionVariables = {
      EDITOR = "nvim";
      GREP_OPTIONS = "--ignore-case --line-number --recursive";
      FZF_DEFAULT_COMMAND = "rg --files";
      FZF_CTRL_T_COMMAND = "$FZF_DEFAULT_COMMAND";
    };
    shellAliases = {
      mwt = "make generate-web-types pathToFrontendRepo=/Users/maxhallinan/Mercury/mercury-web-frontend";
    };
  };
}
