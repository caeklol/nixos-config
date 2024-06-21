{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./remote.nix
    ./polkit.nix
    ./udisks2.nix
    ./i3
    ./gnome.nix
    ./hyprland.nix
  ];

  options.desktop.remote = lib.mkEnableOption "enable remote (vnc for wayland, rdp for x11)";

  options.desktop.env = lib.mkOption {
    type = lib.types.str;
    description = "environment (choose between: i3, gnome, hyprland)";
  };

  config = {
    hardware = {
      opengl = {
        enable = true;
      };
    };

    programs.dconf.enable = true;
  };
}
