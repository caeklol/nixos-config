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

    programs.uwsm = {
      enable = true;
      waylandCompositors.hyprland = {
        binPath = "/run/current-system/sw/bin/Hyprland";
        prettyName = "Hyprland";
      };
    };

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      withUWSM = true;
    };

    #environment.systemPackages = with pkgs; [
    #  greetd.tuigreet
    #];

    systemd.services.greetd.serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal";
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };

    services.greetd = let
      session = {
        command = "${lib.getExe pkgs.uwsm} start hyprland-uwsm.desktop";
        user = "caek";
      }; in {
        enable = true;
        settings = {
          terminal.vt = 1;
          default_session = session;
          initial_session = session;
        };
      #settings = {
      #  default_session = {
      #    command = "tuigreet --time --cmd 'Hyprland'";
      #    user = "greeter";
      #  };
      #};

    };

    #environment.etc."greetd/environments".text = ''
    #  Hyprland
    #'';
  };
}
