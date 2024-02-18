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
    programs.kitty = {
      enable = true;
      font = {
        package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
        name = "JetBrains Mono Nerd Font";
        size = 13;
      };

      shellIntegration = {
        enableBashIntegration = cfg.shells.bash.enable;
        enableZshIntegration = cfg.shells.zsh.enable;
      };

      extraConfig = ''
        map ctrl+shift+t new_tab_with_cwd
      '';
    };

    home.sessionVariables = {
      TERMINAL = "kitty";
    };
  };
}
