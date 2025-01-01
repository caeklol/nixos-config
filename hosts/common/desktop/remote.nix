{
  config,
  pkgs,
  lib,
  ...
}: let
  remote = config.desktop.remote;
  env = config.desktop.env;
  wayland = builtins.elem env ["hyprland"];
in {
  config = lib.mkIf remote {
    services.xrdp = lib.mkIf (!wayland) {
      enable = true;
      defaultWindowManager = let
        commandMap = {
          "i3" = "i3";
          "gnome" = "/run/current-system/sw/bin/gnome-session";
        };
      in
        builtins.getAttr env commandMap;
      openFirewall = true;
    };

    environment.systemPackages = lib.mkIf wayland [
      pkgs.wayvnc
    ];
  };
}
