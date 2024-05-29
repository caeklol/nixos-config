{
  lib,
  pkgs,
  config,
  ...
}: let
  enable = config.desktop.enable && config.desktop.env == "hyprland" ;

  hyprpaper-config = pkgs.writeTextFile {
    name = "hyprpaper-config";
    text = ''
      preload = ${config.desktop.wallpaper}
      wallpaper = ${config.desktop.monitor.name},${config.desktop.wallpaper}
      splash = false
    '';
  };

  modifier = "ALT";
  modifier2 = "SHIFT";
in {
  config = lib.mkIf enable {
    home.packages = with pkgs; [
      hyprpaper
      wl-clipboard
      grim
      slurp
      fuzzel
    ];

    home.file.".config/waybar".source = ./waybar;

    programs.waybar = {
      enable = true;
    };

    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      settings = {
        "$mod" = modifier;
        "$mod2" = modifier2;
        "$terminal" = "kitty";
        "$fileManager" = "${pkgs.gnome.nautilus}/bin/nautilus";
        "$menu" = "fuzzel";
        "$screenshot" = "${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" - | ${pkgs.wl-clipboard}/bin/wl-copy -t image/png";

        exec = [
          "pkill waybar ; waybar --config ~/.config/waybar/config --style ~/.config/waybar/styles.css"
          "pkill hyprpaper ; ${pkgs.hyprpaper}/bin/hyprpaper --config ${hyprpaper-config}"
          "hyprctl setcursor \"macOS-Monterey\" 24"
        ];

        exec-once = [
          "which wayvnc && wayvnc -o ${config.desktop.monitor.name} 0.0.0.0"
          "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
          "lxqt-policykit-agent"
        ];

        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];

        bind =
          [
            "$mod $mod2, S, exec, $screenshot"
            "$mod $mod2, R, exec, hyprctl reload"
            "$mod, Return, exec, $terminal"
            "$mod $mod2, Q, killactive,"
            "$mod $mod2, E, exit,"
            "$mod, E, exec, $fileManager"
            "$mod, F, togglefloating,"
            "$mod, D, exec, $menu"
            "$mod, P, pseudo,"
            "$mod, J, togglesplit,"
            "$mod, left, movefocus, l"
            "$mod, right, movefocus, r"
            "$mod, up, movefocus, u"
            "$mod, down, movefocus, d"
          ]
          ++ (
            # workspaces
            # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
            builtins.concatLists (builtins.genList (
                x: let
                  ws = let
                    c = (x + 1) / 10;
                  in
                    builtins.toString (x + 1 - (c * 10));
                in [
                  "$mod, ${ws}, workspace, ${toString (x + 1)}"
                  "$mod SHIFT, ${ws}, movetoworkspacesilent, ${toString (x + 1)}"
                ]
              )
              10)
          );

		monitor = "${config.desktop.monitor.name},${config.desktop.monitor.resolution}@${builtins.toString config.desktop.monitor.refreshRate},0x0,1";

		env = [
			"XCURSOR_SIZE,24"
			"QT_QPA_PLATFORMTHEME,at5ct"
		];

		input = {
			kb_layout = "us";
			follow_mouse = 1;

			touchpad = {
				natural_scroll = false;
			};
		};

		general = {
			gaps_in = 0;
			gaps_out = 0;
			border_size = 0;
			layout = "dwindle";
			allow_tearing = false;
		};

		decoration = {
			blur = {
				enabled = true;
				size = 3;
				passes = 3;
				new_optimizations = true;
				vibrancy = 0.1696;
				xray = false;
			};
		};

		animations = {
			enabled = false;
		};

		dwindle = {
			pseudotile = true;
			preserve_split = true;
		};

		master = {
			new_is_master = true;
		};

		gestures = {
			workspace_swipe = false;
		};

		misc = {
			force_default_wallpaper = 0;
		};
      };
    };
  };
}
