{
  config,
  lib,
  pkgs,
  ...
}: let
  enabled = config.desktop.env == "sway";
in
  lib.mkIf enabled {
    environment.systemPackages = with pkgs; [
      greetd.tuigreet
    ];

    environment.sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
	  WLR_RENDERER = "vulkan";
    };

    xdg.portal.enable = true;
    xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-wlr];

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
          command = "tuigreet --time --cmd 'sway --unsupported-gpu'";
          user = "greeter";
        };
      };
    };

    environment.etc."greetd/environments".text = ''
      sway
    '';
  }
