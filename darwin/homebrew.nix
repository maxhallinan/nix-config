{...}: {
  homebrew = {
    enable = true;
    onActivation.upgrade = true;
    casks = [
      "figma"
      "iterm2"
      "postman"
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
