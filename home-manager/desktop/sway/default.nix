{
  lib,
  pkgs,
  config,
  ...
}: let
  enable = config.desktop.enable && config.desktop.env == "sway";

  modifier = "Mod1";
  modifier2 = "SHIFT";
in {
  config = lib.mkIf enable {
    home.packages = with pkgs; [
      wl-clipboard
      grim
      slurp
      fuzzel
    ];

    home.file.".config/waybar".source = ./waybar;
	home.file.".config/waybar_start.sh" = {
		text = ''
			${pkgs.waybar}/bin/waybar --config ${config.xdg.configHome}/waybar/config --style ${config.xdg.configHome}/waybar/styles.css
		'';
		executable = true;
	};

    programs.waybar = {
      enable = true;
    };

    wayland.windowManager.sway = {
      enable = true;
	  xwayland = true;

      config = {
        terminal = "kitty"; # change to setting
        modifier = modifier;
		output = {
			"${config.desktop.monitor.name}" = {
				mode = "${config.desktop.monitor.resolution}@${builtins.toString config.desktop.monitor.refreshRate}Hz";
			};
		};

		fonts = {
			names = ["SF Pro Display"];
			size = 10.0;
		};

		bars = [
			{
				command = "${config.xdg.configHome}/waybar_start.sh";
			}
		];

		
        #"$fileManager" = "${pkgs.gnome.nautilus}/bin/nautilus";
        #"$menu" = "fuzzel";
        #"$screenshot" = "${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" - | ${pkgs.wl-clipboard}/bin/wl-copy -t image/png";

		startup = [
			{
			  command = "which wayvnc && wayvnc -o ${config.desktop.monitor.name} 0.0.0.0";
			  always = false;
			}
		];

        #env = [
        #  "XCURSOR_SIZE,24"
        #  "QT_QPA_PLATFORMTHEME,at5ct"
        #];

        #windowrulev2 = [
        #  "float, initialclass:org.gnome.Nautilus"
        #  "size 45% 50%, initialclass:org.gnome.Nautilus"
        #];
      };
    };
  };
}
