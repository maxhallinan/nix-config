{ config, pkgs, home-manager, ... }:

{
  imports = [
    home-manager.darwinModule
    # ./postgresql.nix
    ./homebrew.nix
  ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [ pkgs.vim
      pkgs.alacritty
    ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  programs.zsh.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  users.users = {
    maxhallinan = {
      name = "maxhallinan";
      home = "/Users/maxhallinan";
      shell = pkgs.zsh;
    };
  };

  home-manager = {
    useUserPackages = true;
    verbose = true;
    users.maxhallinan = import ../home-manager/home.nix;
  };

  # system.activationScripts.preActivation = {
  #   enable = true;
  #   text = ''
  #     # if [ ! -d "/Users/maxhallinan/postgres" ]; then
  #     #   echo "bar";
  #     #   mkdir -m 700 -p /Users/maxhallinan/postgres;
  #     #   chown -R maxhallinan:staff /Users/maxhallinan/postgres;
  #     # fi

  #     # if [ ! -d "/usr/local/var" ]; then
  #     #   sudo mkdir $VERBOSE_ARG -m 775 -p /usr/local/var;
  #     #   chown -R maxhallinan:staff /usr/local/var/;
  #     # fi
  #     # if [ ! -d "/usr/local/var/postgres" ]; then
  #     #   sudo mkdir $VERBOSE_ARG -m 775 -p /usr/local/var/postgres;
  #     #   chown -R maxhallinan:staff /usr/local/var/postgres;
  #     # fi
  #     # if [ ! -d "/usr/local/var/log" ]; then
  #     #   sudo mkdir $VERBOSE_ARG -m 775 -p /usr/local/var/log;
  #     #   chown -R maxhallinan:staff /usr/local/var/log;
  #     # fi
  #   '';
  # };
}
