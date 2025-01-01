{
  config,
  pkgs,
  lib,
  ...
}: let
  enabled = config.desktop.env == "gnome";
in {
  environment.systemPackages = with pkgs; [
    gnome-remote-desktop
  ];

  services.xserver = lib.mkIf enabled {
    enable = true;
    desktopManager.gnome.enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };
}
