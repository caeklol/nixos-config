{
  lib,
  pkgs,
  ...
}: let
  wallpaper = builtins.path {
    path = ../wallpaper/wallpaper.png;
    name = "hyprland-wallpaper";
  };

  hyprpaper-config = pkgs.writeTextFile {
    name = "hyprpaper-config";
    text = ''
      preload = ${wallpaper}
      wallpaper = HDMI-A-1,${wallpaper}
      splash = false
    '';
  };

  modifier = "ALT";
  modifier2 = "SHIFT";
in {
  config = {
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
        "$fileManager" = "${pkgs.cinnamon.nemo}/bin/nemo";
        "$menu" = "fuzzel";
        "$screenshot" = "${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" - | ${pkgs.wl-clipboard}/bin/wl-copy -t image/png";

        exec = [
          "pkill waybar ; waybar --config ~/.config/waybar/config --style ~/.config/waybar/styles.css"
          "pkill hyprpaper ; ${pkgs.hyprpaper}/bin/hyprpaper --config ${hyprpaper-config}"
          "hyprctl setcursor \"macOS-Monterey\" 24"
        ];

        exec-once = [
          "which wayvnc && wayvnc -o HDMI-A-1 0.0.0.0"
          "lxqt-policykit-agent"
          "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
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
      };

      extraConfig = builtins.readFile ./hyprland.conf;
    };
  };
}
