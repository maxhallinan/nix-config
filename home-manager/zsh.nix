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

      # Get rid of all unstaged changes
      git-sweep-stage() {
        git stash --keep-index
        git clean --force
      }
    '';
    oh-my-zsh = {
      enable = true;
      plugins = ["git" "tmux" "z"];
    };
    sessionVariables = {
      EDITOR = "nvim";
      FZF_CTRL_T_COMMAND = "$FZF_DEFAULT_COMMAND";
      FZF_DEFAULT_COMMAND = "rg --files";
      GREP_OPTIONS = "--ignore-case --line-number --recursive";
      MWB_BE = "$HOME/Mercury/mercury-web-backend";
      MWB_DB = "mercury-web-backend-development";
      MWB_FE = "$HOME/Mercury/mercury-web-frontend";
    };
    shellAliases = {
      gsst = "git-sweep-stage";
      mwt = "make generate-web-types pathToFrontendRepo=$MWB_FE";
      mgt = "make generate-golden-types";
      pgc = "createdb";
      pgd = "dropdb";
      pgi = "psql -d";
      pgmwb = "psql -d $MWB_DB";
      pgr = "recreatedb";
    };
  };
}
