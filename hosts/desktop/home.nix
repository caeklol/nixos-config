{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../../home-manager
    ../../home-manager/desktop/gnome.nix
  ];

  config = {
    modules = {
      programs.fzf.enable = true;
      programs.omp.enable = true;
      programs.xmrig.enable = true;
      programs.prismlauncher.enable = true;
      browsers.firefox.enable = true;
      editors.neovim.enable = true;
      editors.vscode.enable = true;
      shells.bash.enable = true;
      terminals.kitty.enable = true;
    };

    home.username = "caek";
    home.homeDirectory = "/home/caek";
    home.stateVersion = "23.11";

    home.packages = with pkgs; [
      (discord.override {
        withVencord = true;
      })
      cinny-desktop

      netcat-openbsd
      ferium
      xclip
      btop
      git
      neofetch
      xdotool
      yt-dlp
      ffmpeg
      maim
      tmux

      jetbrains.idea-community
      teams-for-linux
      tor-browser
      obs-studio
      expressvpn
      blender
      google-chrome
      telegram-desktop

      spotify
      ngrok
      steam
      gimp
    ];
  };
}