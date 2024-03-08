{ config, lib, pkgs, ... }:
let
  wallpaper = builtins.path {
    path = ./wallpaper.png;
    name = "i3-wallpaper";
  };
in 
{
	config = {

			home.packages = [
				pkgs.feh
			];

			xsession = {
				enable = true;

				windowManager.i3 = {
					enable = true;
					config = {
						modifier = "Mod4";
						startup = [
							{
								command = "feh --bg-fill -z ${wallpaper}";
								always = true;
							}
							{
								command = "xrandr --output HDMI-0 --mode 1920x1080 --rate 144";
								always = false;
							}
						];
					};
				};
			};
	};
}
