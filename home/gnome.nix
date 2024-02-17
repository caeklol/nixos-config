{ config, lib, pkgs, ... }:
{
  config = {
     home.packages = with pkgs; [
       (catppuccin-gtk.override {
         accents = [ "teal" "blue"];
         variant = "mocha";
       })
       gnome.gnome-tweaks

       papirus-icon-theme

       gnomeExtensions.zen
       gnomeExtensions.user-themes
       gnomeExtensions.dash-to-dock
       gnomeExtensions.blur-my-shell
       gnomeExtensions.switcher
     ];


     
     
	dconf.settings = {
		"org/gnome/shell" = {
			disable-user-extensions = false;
        		enabled-extensions = with pkgs.gnomeExtensions; [ 
				zen.extensionUuid
				user-themes.extensionUuid
				dash-to-dock.extensionUuid
				blur-my-shell.extensionUuid
       				switcher.extensionUuid
			];
      		};

		"org/gnome/desktop/interface" = {
			enable-animations = true;
		};
      
    };
  };
}
