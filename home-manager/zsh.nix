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

      generate-my-web-types() {
        make generate-web-types pathToFrontendRepo=$MWB_FE
        golden_files=$(git diff --name-only master.. | rg 'golden/.*')
        cd $MWB_FE
        for f in $golden_files
        do
          echo "Adding ''${f##'golden/generated-types/typescript/'}";
          # git add ''${f##'golden/generated-types/typescript/'};
        done
        # git stash --keep-index
        # git clean --force
        # git reset
        # git add -p
      }

      my-tags() {
        tags
        yesod-routes-tags $MWB_BE/config/routes.yesodroutes $MWB_BE/tags
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
      gfmom = "gf && gmom";
      gsst = "git-sweep-stage";
      mb = "make build";
      mgt = "make generate-golden-types";
      mhr = "make hlint-refactor";
      mtg = "my-tags";
      mwt = "make generate-web-types pathToFrontendRepo=$MWB_FE";
      mywt = "generate-my-web-types";
      pgc = "createdb";
      pgd = "dropdb";
      pgi = "psql -d";
      pgmwb = "psql -d $MWB_DB";
      pgr = "recreatedb";
    };
  };
}
