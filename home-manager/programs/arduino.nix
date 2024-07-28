{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules;
in {
  options.modules.programs.arduino = {
    enable = lib.mkEnableOption "enable arduino ide";
  };

  config = lib.mkIf cfg.programs.arduino.enable {
    home.packages = with pkgs; [
      arduino-ide
    ];
  };
}
