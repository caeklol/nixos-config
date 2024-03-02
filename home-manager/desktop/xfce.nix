{
  config,
  lib,
  pkgs,
  ...
}: let
  wallpaper = builtins.path {
    path = ./wallpaper.png;
    name = "xfce-wallpaper";
  };
in {
  config = {
	home.packages = [
		pkgs.albert
	];

	gtk = {
		enable = true;
		theme = {
			name = "Catppuccin-Mocha-Standard-Teal-Dark";
			package = pkgs.catppuccin-gtk.override {
				accents = [ "teal" ];
				variant = "mocha";
			};
		};
	};

  dconf.settings = {
    "org/gnome/desktop/interface" = {
		gtk-theme = "Catppuccin-Mocha-Standard-Teal-Dark";
		color-scheme = "prefer-dark";
		icon-theme = "Adwaita";
	};
  };
};
}
