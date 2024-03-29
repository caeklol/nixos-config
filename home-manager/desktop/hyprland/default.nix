{
  lib,
  pkgs,
  ...
}: let
  wallpaper = builtins.path {
    path = ../wallpaper.png;
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
      wofi
      dolphin
      hyprpaper
      apple-cursor
      wl-clipboard
      grim
      slurp
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
        "$fileManager" = "${pkgs.dolphin}/bin/dolphin";
        "$menu" = "wofi --show drun";
        "$screenshot" = "${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" - | ${pkgs.wl-clipboard}/bin/wl-copy";

        exec = [
          "pkill waybar ; waybar --config ~/.config/waybar/config --style ~/.config/waybar/styles.css"
          "pkill hyprpaper ; ${pkgs.hyprpaper}/bin/hyprpaper --config ${hyprpaper-config}"
          "gsettings set org.gnome.desktop.interface cursor-theme 'macOS-Monterey'"
          "hyprctl setcursor \"macOS-Monterey\""
        ];

        exec-once = [
          "which wayvnc && wayvnc"
        ];

        bind =
          [
            "$mod $mod2, S, exec, $screenshot"
            "$mod, F, exec, firefox"
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
                  "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
                ]
              )
              10)
          );
      };

      extraConfig = builtins.readFile ./hyprland.conf;
    };
  };
}
