{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules;
in {
  options.modules.programs.steam = {
    enable = lib.mkEnableOption "enable fzf";
  };

  config = lib.mkIf cfg.programs.steam.enable {
    home.packages = with pkgs; [
      steam
    ];
  };
}
