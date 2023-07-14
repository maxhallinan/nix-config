{...}: {
  homebrew = {
    enable = true;
    onActivation.upgrade = true;
    casks = [
      "figma"
      "iterm2"
      "libreoffice"
      "postman"
      "terminal-notifier"
    ];
    brews = [
      "postgis"
      {
        name = "postgresql@14";
        start_service = true;
        restart_service = true;
      }
    ];
  };
}
