{config, pkgs, lib, ...}: {
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
        name = "Colloid";
        package = pkgs.colloid-icon-theme;
      };

      theme = {
        name = "WhiteSur-Dark";
        package = pkgs.whitesur-gtk-theme.override {
			colorVariants = ["Dark"];
			nautilusStyle = "glassy";
		};
      };
 gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
		gtk3 = {
		  #bookmarks = [
		  #  "file://${config.home.homeDirectory}/Documents"
		  #  "file://${config.home.homeDirectory}/Downloads"
		  #  "file://${config.home.homeDirectory}/Music"
		  #  "file://${config.home.homeDirectory}/Pictures"
		  #  "file://${config.home.homeDirectory}/Videos"
		  #];
		  extraConfig = {
			gtk-xft-antialias = 1;
			gtk-xft-hinting = 1;
			gtk-xft-hintstyle = "hintfull";
			gtk-xft-rgba = "rgb";
			gtk-application-prefer-dark-theme = 1;
		  };
		};

		gtk2.extraConfig = ''
		  gtk-xft-antialias=1
		  gtk-xft-hinting=1
		  gtk-xft-hintstyle="hintslight"
		  gtk-xft-rgba="rgb"
		'';

		gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
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
	  gnome.file-roller
	  gnome.nautilus
      gnome.nautilus-python 		# sorry but nautilus is just good
      nautilus-open-any-terminal
    ];

    xdg = {
      mime.enable = true;
      mimeApps.associations.added = {
        "inode/directory" = "nemo.desktop";
        "image/*" = "mpv.desktop";
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
