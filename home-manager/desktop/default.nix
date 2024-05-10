{pkgs, ...}: {
  imports = [
    ./polkit.nix
  ];
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
