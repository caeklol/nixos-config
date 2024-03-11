# Useful resource: https://github.com/breuerfelix/dotfiles/blob/main/desktop/polybar.nix
{
  config,
  lib,
  pkgs,
  ...
}: let
  wallpaper = builtins.path {
    path = ../wallpaper.png;
    name = "i3-wallpaper";
  };
in {
  config = {
    home.packages = with pkgs; [
      polybar-pulseaudio-control
      pavucontrol
      cmus
      mpv
      feh
    ];

    home.file.polybar = {
      executable = true;
      target = ".config/polybar/start.sh";
      text = ''
        #!/run/current-system/sw/bin/bash

        # terminate already running bar instances
        pkill polybar

        # start polybar on all monitors
        for m in $(polybar --list-monitors | cut -d":" -f1); do
            MONITOR=$m polybar bar &
        done
      '';
    };

    # maybe ?
    #home.file.i3 = {
    #	executable = true;
    #	target = ".config/i3/start.sh";
    #	text = ./i3.sh;
    #};

    xsession = {
      enable = true;

      windowManager.i3 = {
        enable = true;
        config = {
          bars = [];
          modifier = "Mod4";
          window = {
            titlebar = false;
            border = 0;
          };

          floating = {
            titlebar = false;
            border = 0;
          };

          startup = [
            {
              command = "feh --bg-fill -z ${wallpaper}";
              always = true;
            }

            {
              command = "~/.config/polybar/start.sh";
              always = true;
            }
          ];
        };
      };
    };

    services.polybar = {
      enable = true;
      package = pkgs.polybar.override {
        alsaSupport = true;
      };
      script = "exit 0";
      config = ./polybar.ini;
    };
  };
}
