{
  config,
  lib,
  ...
}: let
  enabled = config.desktop.env == "gnome";
in {
  services.xserver = lib.mkIf enabled {
    desktopManager.gnome.enable = true;
    displayManager.lightdm.enable = true;
  };
}
