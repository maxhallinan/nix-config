{ pkgs, ... }:

{
  programs.bash.enable = true;
  programs.zsh = {
    enable = true;
    initExtra = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"
      export PATH=$N_PREFIX/bin:$PATH

      run-query() {
        tsh db connect $1 < $2
      }

      recreatedb() {
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
        # https://unix.stackexchange.com/a/710369
        golden_files=(''${(f)"$(git diff --name-only master.. | rg 'golden/.*')"})
        cd $MWB_FE
        for f in $golden_files
        do
          f_trimmed=''${f##'golden/generated-types/typescript/'}
          echo "Adding $f_trimmed";
          git add $f_trimmed;
        done
        git stash --keep-index
        git clean --force
        git reset
        git add -p
      }

      my-tags() {
        tags
        yesod-routes-tags $MWB_BE/config/routes.yesodroutes $MWB_BE/tags
      }

      # https://github.com/NixOS/nix/issues/3616
      # if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
      #   source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      # fi
      [[ ! $(command -v nix) && -e "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh" ]] && source "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"
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
      MWB_REPLICA_DB = "mercury-web-backend-replica";
    };
    shellAliases = {
      gfmom = "gf && gmom";
      gsst = "git-sweep-stage";
      mb = "make build warn=1";
      mr = "make run";
      mfd = "make fake-data";
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
      pgrmwb = "recreatedb $MWB_DB";
      pgmwbf = "psql -d $MWB_DB -a -f";
      rqsp = "run-query $MWB_REPLICA_DB";
    };
  };
}
