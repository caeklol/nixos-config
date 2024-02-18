{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../common
    ../common/gnome
  ];

  config = {
    modules = {
      browsers.firefox.enable = true;
      editors.neovim.enable = true;
      editors.vscode.enable = true;
      programs.fzf.enable = true;
      programs.omp.enable = true;
      programs.xmrig.enable = true;
      shells.bash.enable = true;
      terminals.kitty.enable = true;
    };

    home.username = "caek";
    home.homeDirectory = "/home/caek";
    home.stateVersion = "22.11";

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
