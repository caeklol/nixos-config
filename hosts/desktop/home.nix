{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../../home-manager
    ../../home-manager/desktop/i3.nix
  ];

  config = {
    modules = {
      programs.fzf.enable = true;
      programs.tmux.enable = true;
      programs.omp.enable = true;
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
      krita 
	  gparted
    ];
  };
}
