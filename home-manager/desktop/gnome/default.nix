{
  config,
  lib,
  pkgs,
  ...
}: let
  enable = config.desktop.enable && config.desktop.env == "gnome";
in {
  config = lib.mkIf enable {
    home.packages = with pkgs; [
      gnome.gnome-tweaks

      gnomeExtensions.zen
      gnomeExtensions.user-themes
      gnomeExtensions.just-perfection
      gnomeExtensions.dash-to-dock
    ];

    home.file.display = {
      executable = true;
      target = ".config/autostart/display_config.desktop";
      text = ''
        xrandr --output ${config.desktop.monitor.name} --mode ${config.desktop.monitor.resolution} --rate ${builtins.toString config.desktop.monitor.refreshRate}
      '';
    };

    dconf.settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = with pkgs.gnomeExtensions; [
          zen.extensionUuid
          user-themes.extensionUuid
          just-perfection.extensionUuid
          dash-to-dock.extensionUuid
        ];
      };
      "org/gnome/desktop/session" = {
        idle-delay = lib.hm.gvariant.mkUint32 0;
      };
      "org/gnome/shell/extensions/dash-to-dock" = {
        height-fraction = 1.0;
        dash-max-icon-size = 64;
        running-indicator-style = "DOTS";
      };
      "org/gnome/settings-daemon/plugins/power" = {
        sleep-inactive-ac-type = "nothing";
      };

      "org/gnome/desktop/wm/preferences" = {
        button-layout = "appmenu:minimize,maximize,close";
      };

      "org/gnome/desktop/background" = {
        picture-options = "zoom";
        picture-uri-dark = config.desktop.wallpaper;
      };

      "org/gnome/desktop/input-sources" = {
        sources = [(lib.hm.gvariant.mkTuple ["xkb" "us"])];
        xkb-options = ["terminate:ctrl_alt_bksp"];
      };

      "org/gnome/desktop/interface" = {
        enable-animations = true;
        font-antialiasing = "grayscale";
        font-hinting = "slight";
        gtk-theme = "catppuccin-mocha-teal-standard+default";
        color-scheme = "prefer-dark";
        gtk-enable-primary-paste = false;
      };

      "org/gnome/desktop/peripherals/mouse" = {
        accel-profile = "flat";
        speed = 0.17322834645669283;
      };

      "org/gnome/desktop/privacy" = {
        old-files-age = lib.hm.gvariant.mkUint32 30;
        recent-files-max-age = -1;
      };

      "org/gnome/nautilus/icon-view" = {
        default-zoom-level = "small-plus";
      };

      "org/gnome/nautilus/preferences" = {
        default-folder-viewer = "list-view";
        migrated-gtk-settings = true;
        search-filter-time-type = "last_modified";
      };

      "org/gnome/shell" = {
        favorite-apps = ["vesktop.desktop" "firefox.desktop" "kitty.desktop" "spotify.desktop" "org.gnome.Nautilus.desktop"];
        # should hopefully work regardless if the apps are installed or not
      };

      "org/gnome/shell/extensions/just-perfection" = {
        accessibility-menu = false;
        activities-button = false;
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
        panel-size = 40;
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
        name = "catppuccin-mocha-teal-standard+default";
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
