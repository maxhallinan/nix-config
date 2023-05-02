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
      MWB_DB = "mercury-web-backend-development";
      MWB_FE = "$HOME/Mercury/mercury-web-frontend";
      MWB_BE = "$HOME/Mercury/mercury-web-backend";
    };
    shellAliases = {
      mwt = "make generate-web-types pathToFrontendRepo=/Users/maxhallinan/Mercury/mercury-web-frontend";
      pgc = "createdb";
      pgd = "dropdb";
      pgi = "psql -d";
      pgmwb = "psql -d $MWB_DB";
      pgr = "recreatedb";
    };
  };
}
