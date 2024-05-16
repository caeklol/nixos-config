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
      programs.obsidian = {
        enable = true;
        syncthing = true;
      };
      programs.arduino.enable = true;

      browsers.firefox.enable = true;
      editors.neovim.enable = true;
      editors.vscode.enable = true;
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
	    sensitivity = 0.55;
        accel_profile = "flat";
      };
    };

    xsession.windowManager.i3.config.startup = [
      {
        command = "xrandr --output DP-0 --mode 2560x1440 --rate 165";
        always = true;
      }
      {
        command = "xinput set-prop $(xinput list --id-only 'Glorious Model O') \"libinput Accel Profile Enabled\" 0 1 0";
        always = true;
      }
      {
        command = "xinput set-prop $(xinput list --id-only 'Glorious Model O') \"libinput Middle Emulation Enabled\" 0";
        always = true;
      }
    ];
  };
}
