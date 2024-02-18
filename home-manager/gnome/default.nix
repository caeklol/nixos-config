{
  config,
  lib,
  pkgs,
  ...
}: let
  wallpaper = builtins.path {
    path = ./wallpaper.png;
    name = "gnome-wallpaper";
  };
in {
  config = {
    home.packages = with pkgs; [
      (catppuccin-gtk.override {
        accents = ["teal" "blue"];
        variant = "mocha";
      })
      gnome.gnome-tweaks

      papirus-icon-theme

      gnomeExtensions.zen
      gnomeExtensions.user-themes
      gnomeExtensions.just-perfection
      gnomeExtensions.blur-my-shell
    ];

    dconf.settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = with pkgs.gnomeExtensions; [
          zen.extensionUuid
          user-themes.extensionUuid
          just-perfection.extensionUuid
          blur-my-shell.extensionUuid
        ];
      };

      "org/gnome/Console" = {
        font-scale = 1.4000000000000004;
        last-window-size = lib.hm.gvariant.mkTuple [1404 965];
      };

      "org/gnome/desktop/wm/preferences" = {
        button-layout = "appmenu:minimize,maximize,close";
      };

      "org/gnome/desktop/background" = {
        picture-options = "zoom";
        picture-uri-dark = wallpaper;
      };

      "org/gnome/desktop/input-sources" = {
        sources = [(lib.hm.gvariant.mkTuple ["xkb" "us"])];
        xkb-options = ["terminate:ctrl_alt_bksp"];
      };

      "org/gnome/desktop/interface" = {
        enable-animations = true;
        font-antialiasing = "grayscale";
        font-hinting = "slight";
        gtk-theme = "Catppuccin-Mocha-Standard-Teal-Dark";
        icon-theme = "Papirus-Dark";
      };

      "org/gnome/desktop/peripherals/mouse" = {
        accel-profile = "flat";
        speed = -0.338521;
      };

      "org/gnome/desktop/privacy" = {
        old-files-age = lib.hm.gvariant.mkUint32 30;
        recent-files-max-age = -1;
      };

      "org/gnome/nautilus/icon-view" = {
        default-zoom-level = "small-plus";
      };

      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };

      "org/gnome/nautilus/preferences" = {
        default-folder-viewer = "list-view";
        migrated-gtk-settings = true;
        search-filter-time-type = "last_modified";
      };

      "org/gnome/shell" = {
        favorite-apps = ["discord.desktop" "firefox.desktop" "kitty.desktop" "spotify.desktop" "org.gnome.Nautilus.desktop"];
        # should hopefully work regardless if the apps are installed or not
      };

      "org/gnome/shell/extensions/just-perfection" = {
        accessibility-menu = false;
        activities-button = true;
        animation = 5;
        background-menu = true;
        calendar = true;
        controls-manager-spacing-size = 0;
        dash = true;
        dash-app-running = false;
        dash-icon-size = 32;
        dash-separator = false;
        double-super-to-appgrid = true;
        events-button = false;
        keyboard-layout = false;
        looking-glass-width = 0;
        osd = true;
        panel = true;
        panel-button-padding-size = 9;
        panel-icon-size = 16;
        panel-in-overview = false;
        panel-indicator-padding-size = 5;
        panel-notification-icon = true;
        panel-size = 32;
        power-icon = true;
        quick-settings = true;
        ripple-box = false;
        search = false;
        show-apps-button = false;
        startup-status = 0;
        theme = true;
        weather = false;
        window-demands-attention-focus = true;
        window-picker-icon = false;
        window-preview-caption = true;
        window-preview-close-button = true;
        workspace = false;
        workspace-background-corner-size = 0;
        workspace-popup = true;
        workspace-switcher-size = 0;
        workspaces-in-app-grid = false;
        world-clock = false;
      };

      "org/gnome/shell/extensions/user-theme" = {
        name = "Catppuccin-Mocha-Standard-Teal-Dark";
      };

      "org/gnome/shell/world-clocks" = {
        locations = [];
      };

      "org/gnome/tweaks" = {
        show-extensions-notice = false;
      };
    };
  };
}
