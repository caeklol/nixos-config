{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules;
in {
  options.modules.programs.obsidian = {
    enable = lib.mkEnableOption "enable obsidian";
    syncthing = lib.mkEnableOption "enable syncthing with obsidian";
  };

  config = lib.mkIf cfg.programs.obsidian.enable {
    home.packages = with pkgs; [
      obsidian
    ];

    services.syncthing.enable = cfg.programs.obsidian.syncthing;
  };
}
