{
  config,
  lib,
  pkgs,
  ...
}: let
  tmux = config.modules.programs.tmux;
in {
  options.modules.programs.tmux = {
    enable = lib.mkEnableOption "enable tmux";
  };

  config = lib.mkIf tmux.enable {
    programs.tmux = {
      enable = true;
      plugins = with pkgs; [
        tmuxPlugins.catppuccin
      ];

      extraConfig = ''
        set-window-option -g status-style bg=#74c7ec,fg=#45475a
      '';
    };
  };
}
