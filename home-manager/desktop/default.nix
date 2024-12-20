{
  config,
  pkgs,
  lib,
  ...
}: let
  wayland = config.desktop.env == "hyprland";
in {
  imports = [
    ./polkit.nix
    ./hyprland
    ./i3
    ./gnome
  ];

  options = {
    desktop = {
      enable = lib.mkEnableOption "desktop";
      env = lib.mkOption {
        description = "desktop environment"; # As in, the actual
        type = lib.types.enum ["hyprland" "i3" "gnome"];
      };
      wallpaper = lib.mkOption {
        description = "path to wallpaper";
        default = builtins.path {
          path = ./wallpaper/wallpaper.png;
          name = "wallpaper";
        };
        type = lib.types.path;
      };
      monitor = {
        name = lib.mkOption {
          description = "display to use";
          example = "DP-1";
          type = lib.types.str;
        };

        resolution = lib.mkOption {
          description = "resolution to use for the monitor";
          example = "2560x1440";
          type = lib.types.str;
        };

        refreshRate = lib.mkOption {
          description = "refresh rate to use for the monitor";
          example = 165;
          type = lib.types.numbers.positive;
        };
      };
    };
  };

  config = {
    gtk = {
      enable = true;
      cursorTheme = {
        name = "macOS-Monterey";
        package = pkgs.apple-cursor;
        size = 24;
      };
      font = {
        name = "SF Pro Display";
        package = pkgs.apple-fonts;
        size = 11;
      };

      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };

      theme = {
        name = "catppuccin-mocha-teal-standard+default";
        package = pkgs.catppuccin-gtk.override {
          accents = ["teal"];
          variant = "mocha";
        };
      };
    };

    qt = {
      enable = true;
      platformTheme.name = "gtk2";
      style.name = "gtk2";
    };

    home.packages = with pkgs;
      [
        # okay maybe nautilus isn't that good not WHY DOES libadwaita IGNORE THEMES
        # nevermind problem resolved itself
        #(cinnamon.nemo-with-extensions.override { extensions = with cinnamon; [ nemo-fileroller ]; })
        nautilus
        celluloid
        mpv
        pavucontrol
        pamixer
        apple-fonts
        loupe
      ]
      ++ (
        if wayland
        then [
          hyprpaper
          wl-clipboard
          grim
          slurp
          fuzzel
        ]
        else [
          xclip
          noto-fonts
          maim
        ]
      );

    xdg = {
      mime.enable = true;
      mimeApps.defaultApplications = {
        "inode/directory" = "nautilus.desktop";
        "image/*" = "loupe.desktop";
      };
    };

    home.pointerCursor = {
      x11.enable = true;
      name = "macOS-Monterey";
      package = pkgs.apple-cursor;
      size = 24;
    };

    services.udiskie = {
      enable = true;
      automount = true;
      notify = false;
      tray = "never";
    };

    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        serif = ["New York"];
        sansSerif = ["SF Pro Display"];
        monospace = ["JetBrains Mono Nerd Font"];
      };
    };
  };
}
