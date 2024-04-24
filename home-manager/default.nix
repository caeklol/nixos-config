{
  config,
  inputs,
  outputs,
  ...
}: {
  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.stable-packages
    ];

    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  imports = [
    ./virtualization

    ./browsers/firefox.nix

    ./editors/neovim.nix
    ./editors/vscode.nix

    ./programs/prismlauncher.nix
    ./programs/obsidian.nix
    ./programs/arduino.nix
    ./programs/fzf.nix
    ./programs/tmux.nix
    ./programs/omp

    ./programs/git.nix

    ./shells/bash.nix
    ./shells/zsh.nix

    ./terminals/kitty.nix
  ];

  xdg.userDirs = {
    enable = true;
    desktop = "${config.home.homeDirectory}";
    documents = "${config.home.homeDirectory}";
    download = "${config.home.homeDirectory}/downloads";
    music = "${config.home.homeDirectory}";
    pictures = "${config.home.homeDirectory}/pictures";
    templates = "${config.home.homeDirectory}";
    videos = "${config.home.homeDirectory}/videos";
  };

  news = {
    display = "silent";
    json = {};
    entries = [];
  };

  programs.home-manager.enable = true;
}
