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
    ../../home-manager/desktop/hyprland # TODO: Make into option (config = desktop.enable, desktop.env)
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
      #(discord.override {
      #  withVencord = true;
      #})
      vesktop
      cinny-desktop

      ferium
      xclip
      btop
      git
      neofetch
      xdotool
      yt-dlp
      ffmpeg
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
      bruno
    ];

    fonts.fontconfig.enable = true;

    home.sessionVariables = {
      EDITOR = "nvim";
      TERMINAL = "kitty";
    };

    wayland.windowManager.hyprland.settings = {
      input = {
        accel_profile = "flat";
      };
    };

    #xsession.windowManager.i3.config.startup = [
    #  {
    #    command = "xrandr --output HDMI-0 --mode 1920x1080 --rate 60";
    #    always = true;
    #  }
    #  {
    #    command = "xinput set-prop $(xinput list --id-only 'Glorious Model O') \"libinput Accel Profile Enabled\" 0 1 0";
    #    always = true;
    #  }
    #];
  };
}
