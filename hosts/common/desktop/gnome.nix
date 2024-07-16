{
  config,
  lib,
  ...
}: let
  enabled = config.desktop.env == "gnome";
in {
  services.xserver = lib.mkIf enabled {
    enable = true;
    desktopManager.gnome.enable = true;
    displayManager.lightdm.enable = true;
  };
}
