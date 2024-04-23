{
  config,
  pkgs,
  lib,
  ...
}: let
  enabled = config.desktop.env == "i3";
in {
  imports = [
    ../bluetooth
  ];

  config = {
    environment.pathsToLink = lib.mkIf enabled ["/libexec"];

    services = {
	  displayManager = lib.mkIf enabled {
        defaultSession = "none+i3";
      };
	  
	  xserver = lib.mkIf enabled {
      enable = true;

      desktopManager = {
        xterm.enable = false;
      };

      

      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          dmenu
        ];
      };
    };
  };
  };
}
