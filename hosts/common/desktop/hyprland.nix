{
  config,
  inputs,
  pkgs,
  lib,
  ...
}: let
  enabled = config.desktop.env == "hyprland";
in {
  config = lib.mkIf enabled {
    environment.sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
    };

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    environment.systemPackages = with pkgs; [
      greetd.tuigreet
    ];

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
  };
}
