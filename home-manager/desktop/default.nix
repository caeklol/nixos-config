{pkgs, lib, ...}: {
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
        name = "WhiteSur";
        package = pkgs.whitesur-icon-theme;
      };

      theme = {
        name = "Catppuccin-Mocha-Standard-Teal-Dark";
        package = pkgs.catppuccin-gtk.override {
          accents = ["teal" "blue"];
          variant = "mocha";
        };
      };
    };

    qt = {
      enable = true;
      platformTheme = {
        name = "gtk";
      };
      style = {
        name = "qt5gtk2";
        #package = pkgs.adwaita-qt;
      };
    };

    home.packages = with pkgs; [
      cinnamon.nemo
    ];

    xdg = {
      mime.enable = true;
      mimeApps.associations.added = {
        "inode/directory" = "nemo.desktop";
      };
    };

    home.pointerCursor = {
      x11.enable = true;
      name = "macOS-Monterey";
      package = pkgs.apple-cursor;
      size = 24;
    };
  };
}
