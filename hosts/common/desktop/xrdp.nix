{ config, lib, ... }:
let
	xrdp = config.desktop.xrdp;
	envMap = {
		"i3" = "i3";
		"gnome" = "gnome-session";
	};
	env = builtins.getAttr config.desktop.env envMap;
in
{
	options.desktop.xrdp = lib.mkEnableOption "enable xrdp";

	config = {
		services.xrdp = lib.mkIf xrdp {
			enable = true;
			openFirewall = true;
			defaultWindowManager = env;
		};
	};
}
