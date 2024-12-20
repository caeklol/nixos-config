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
      env = "hyprland";
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
      programs.steam.enable = true;

      browsers.firefox.enable = true;
      editors.neovim.enable = true;
      shells.bash.enable = true;
      terminals.kitty.enable = true;

      virtualization.enable = true;
    };

    home.username = "caek";
    home.homeDirectory = "/home/caek";
    home.stateVersion = "24.05";
    home.shellAliases.home-manager = "home-manager -b backup";

    home.packages = with pkgs; [
      discord
      vesktop


      btop
      git
      neofetch
      yt-dlp
      ffmpeg
      tmux
      devenv
      gnupg
      gpg-tui

      jetbrains.idea-community
      teams-for-linux
      tor-browser
      obs-studio
      blender
      telegram-desktop
      tor-browser
      mullvad-browser

      spotify
      ngrok
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
