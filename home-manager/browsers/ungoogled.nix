{
  config,
  pkgs,
  lib,
  ...
}: let
  ungoogled = config.modules.browsers.ungoogled;
in {
  options.modules.browsers.ungoogled = {
    enable = lib.mkEnableOption "enable ungoogled";
  };

  config = lib.mkIf ungoogled.enable {
    programs.chromium = {
      enable = true;
      package = pkgs.ungoogled-chromium;
    };
  };
}
