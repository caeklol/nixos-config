{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../../home-manager
    ../../home-manager/desktop
  ];

  config = {
    desktop = {
      enable = true;
      env = "gnome";
      wallpaper = builtins.path {
        path = ../../home-manager/desktop/wallpaper/leaves.png;
        name = "wallpaper";
      };
      monitor = {
        name = "DP-1";
        resolution = "2560x1440";
        refreshRate = 165;
      };
    };

    modules = {
      programs.fzf.enable = true;
      programs.tmux.enable = true;
      programs.omp.enable = true;
      programs.prismlauncher.enable = true;
      programs.obsidian = {
        enable = true;
        syncthing = true;
      };
      programs.arduino.enable = true;

      browsers.ungoogled.enable = true;
      editors.neovim.enable = true;
      shells.bash.enable = true;
      terminals.kitty.enable = true;

      virtualization.enable = true;
    };

    home.username = "caek";
    home.homeDirectory = "/home/caek";
    home.stateVersion = "23.11";

    home.packages = with pkgs; [
      (discord.override {
        withVencord = true;
      })
      vesktop
      cinny-desktop

      cura

      btop
      git
      neofetch
      yt-dlp
      ffmpeg
      tmux
      devenv
      gnupg
      gpg-tui

      # jetbrains.idea-community
      teams-for-linux
      tor-browser
      obs-studio
      blender
      telegram-desktop
      tor-browser
      mullvad-browser

      spotify 
      ngrok
      steam
      gimp
      gparted
      bruno
    ];

    wayland.windowManager.hyprland.settings = {
      input = {
        sensitivity = 0.51;
        accel_profile = "flat";
      };
    };
  };
}
