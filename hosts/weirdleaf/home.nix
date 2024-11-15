{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../../home-manager
  ];

  config = {
    modules = {
      programs.tmux.enable = true;
     shells.bash.enable = true;
    };

    home.username = "caek";
    home.homeDirectory = "/home/caek";
    home.stateVersion = "24.05";
    home.shellAliases.home-manager = "home-manager -b backup";

    home.packages = with pkgs; [];
  };
}
