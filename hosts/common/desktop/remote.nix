{
  config,
  pkgs,
  lib,
  ...
}: let
  remote = config.desktop.remote;
  envMap = {
    "i3" = "i3";
    "gnome" = "gnome-session";
    "hyprland" = "Hyprland";
  };
  env = builtins.getAttr config.desktop.env envMap;
  wayland = config.desktop.env == "hyprland";
  xorg = !wayland;
in {
  config = {
    services.xrdp = lib.mkIf xorg {
      enable = true;
      defaultWindowManager = env;
	  openFirewall = true;
    };

    environment.systemPackages = lib.mkIf wayland [
      pkgs.wayvnc
    ];
  };
}
