{ config, inputs, pkgs, ... }:
{

  home.username = "caek";
  home.homeDirectory = "/home/caek";

  home.stateVersion = "22.11";

  imports = [
     ../common/unfree.nix
     ../common/bash.nix
     ../common/gnome.nix
     ../common/firefox.nix
     ../common/kitty.nix
     ../common/omp.nix
     ../common/neovim.nix
     ../common/vscode.nix
     ../common/fzf.nix
     ../common/xmrig.nix
  ];

  home.packages = with pkgs; [
      (discord.override {
        withVencord = true;
      })
      cinny-desktop
     
      # something weird happened with netcat i have to specify the version now
      netcat-openbsd
      ferium
      xclip
      btop
      git
      neofetch
      yt-dlp
      ffmpeg
      maim
      tmux
  
      jetbrains.idea-community
      teams-for-linux
      prismlauncher
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

  # dotfiles would be here
  home.file = {};

  # envvars but sourcing:
  # ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  # or
  # /etc/profiles/per-user/caek/etc/profile.d/hm-session-vars.sh
  # is required without home-manager managing shell
  # idk if i set that up

  # no more random gnome dirs
  # like what is ~/Templates for ???
  xdg.userDirs.enable = true;
  xdg.userDirs.desktop = "${config.home.homeDirectory}";
  xdg.userDirs.documents = "${config.home.homeDirectory}";
  xdg.userDirs.download = "${config.home.homeDirectory}/downloads";
  xdg.userDirs.music = "${config.home.homeDirectory}";
  xdg.userDirs.pictures = "${config.home.homeDirectory}/pictures";
  xdg.userDirs.templates = "${config.home.homeDirectory}";
  xdg.userDirs.videos = "${config.home.homeDirectory}/videos";

  #home.sessionVariables = {
  #  EDITOR = "nvim";
  #  BROWSER = "firefox";
  #  TERMINAL = "kitty";
  #};

  programs.home-manager.enable = true;
}

