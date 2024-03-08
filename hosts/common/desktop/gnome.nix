{ ... }:
let
	enabled = config.desktop.env == "gnome";
in
{
	services.xserver = {
		desktopManager.gnome.enable = true;
		displayManager.lightdm.enable = true;
	};
}
