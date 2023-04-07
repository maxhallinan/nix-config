{...}: {
  homebrew = {
    enable = true;
    onActivation.upgrade = true;
    brews = [
      {
        name = "postgresql@14";
        start_service = true;
        restart_service = true;
      }
      "postgis"
    ];
  };
}
