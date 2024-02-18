{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules;
in {
  options.modules.programs.prismlauncher = {
    enable = lib.mkEnableOption "enable prismlauncher";
  };

  config = lib.mkIf cfg.programs.prismlauncher.enable {
     home.packages = with pkgs; [
       prismlauncher
     ];
  };
}
