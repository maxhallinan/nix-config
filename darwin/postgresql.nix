{
  config,
  pkgs,
  ...
}:
{
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_15;
    dataDir = "/Users/maxhallinan/postgres";
    extraPlugins = [pkgs.postgresql_15.pkgs.postgis];
    settings = {
      timezone = "UTC";
    };
    authentication = pkgs.lib.mkOverride 10 ''
      local all all trust
      host all all 127.0.0.1/32 trust
      host all all ::1/128 trust
    '';
  };
  launchd.user.agents.postgresql.serviceConfig = {
    StandardErrorPath = "/Users/maxhallinan/postgres.error.log";
    StandardOutPath = "/Users/maxhallinan/postgres.out.log";
  };
}
