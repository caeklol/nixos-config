{
  config,
  lib,
  pkgs,
  ...
}: let
  enabled = config.desktop.env == "hyprland";
in
  lib.mkIf enabled {
    environment.systemPackages = with pkgs; [
      greetd.tuigreet
    ];

    environment.sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
    };

    programs.hyprland.enable = true;

    xdg.portal.enable = true;
    xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-hyprland];

    systemd.services.greetd.serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal";
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "tuigreet --time --cmd 'Hyprland'";
          user = "greeter";
        };
      };
    };

    environment.etc."greetd/environments".text = ''
      Hyprland
    '';
  }
