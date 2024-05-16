# Useful resource: https://github.com/breuerfelix/dotfiles/blob/main/desktop/polybar.nix
{
  config,
  lib,
  pkgs,
  ...
}: let
  enable = config.desktop.enable && config.desktop.env == "i3";
  modifier = "Mod1";
in {
  config = lib.mkIf enable {
    home.packages = with pkgs; [
      polybar-pulseaudio-control
      pavucontrol
      noto-fonts
      feh # background
      apple-fonts
      maim
      xclip
      rofi
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
          modifier = modifier;
          window = {
            titlebar = false;
            border = 0;
          };

          fonts = {
            names = ["SF Pro Display" "SF Pro Display"];
            size = 9.0;
          };

          floating = {
            titlebar = true;
            border = 1;
          };

          keybindings = lib.mkOptionDefault {
            "${modifier}+Shift+s" = "exec maim -s -m 4 | xclip -selection clipboard -t image/png";
            "${modifier}+d" = "exec rofi -show drun";
            "${modifier}+f" = "floating toggle";
          };

          startup = [
            {
				command = "feh --bg-fill -z ${config.desktop.wallpaper}";
				always = true;
            }
            {
				command = "~/.config/polybar/start.sh";
				always = true;
            }
			{
				command = "xrandr --output ${config.desktop.monitor.name} --mode ${config.desktop.monitor.resolution} --rate ${builtins.toString config.desktop.monitor.refreshRate}";
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

    services.picom = {
      enable = true;
      vSync = true;
      backend = "glx";
      settings = {
        blur = {
          method = "dual_kawase";
          strength = 10;
        };

        blur-background-exclude = [
          "class_g = 'slop'"
        ];
      };
    };
  };
}
