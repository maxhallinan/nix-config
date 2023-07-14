{ config, pkgs, inputs, ... }:

{
  imports = [
    ./alacritty.nix
    ./autojump.nix
    ./direnv.nix
    ./git.nix
    ./neovim.nix
    ./ssh.nix
    ./starship.nix
    ./tmux.nix
    ./zsh.nix
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "maxhallinan";
  home.homeDirectory = "/Users/maxhallinan";

  home.packages = with pkgs; [fzf nodejs tmux];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # home.activation = {
  #   postgres = config.lib.dag.entryAfter [ "writeBoundary" ] ''
  #     if [ ! -d "/usr/local/var" ]; then
  #       sudo mkdir $VERBOSE_ARG "/usr/local/var"
  #     fi
  #     if [ ! -d "/usr/local/var/postgres" ]; then
  #       sudo mkdir $VERBOSE_ARG "/usr/local/var/postgres"
  #     fi
  #   '';
  # };
}
