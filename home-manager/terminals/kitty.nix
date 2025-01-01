{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules;
in {
  options.modules.terminals.kitty = {
    enable = lib.mkEnableOption "enable kitty";
  };

  config = lib.mkIf cfg.terminals.kitty.enable {
    home.sessionVariables.TERMINAL = "kitty";

    programs.kitty = {
      enable = true;
      font = {
        name = "JetBrainsMono Nerd Font";
        size = 13;
      };

      shellIntegration = {
        enableBashIntegration = cfg.shells.bash.enable;
        enableZshIntegration = cfg.shells.zsh.enable;
      };

      themeFile = "adwaita_dark";

      extraConfig = ''
              map ctrl+shift+t new_tab_with_cwd
              window_padding_width 4
      '';
    };
  };
}
