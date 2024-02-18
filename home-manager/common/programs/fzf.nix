{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules;
in {
  options.modules.programs.fzf = {
    enable = lib.mkEnableOption "enable fzf";
  };

  config = lib.mkIf cfg.programs.fzf.enable {
    home.packages = with pkgs; [
      fd
    ];

    programs.fzf = {
      enable = true;
      defaultCommand = "${pkgs.fd}/bin/fd -E node_modules/ --type directory";
      changeDirWidgetCommand = "${pkgs.fd}/bin/fd -E node_modules/ --type directory";
      enableBashIntegration = cfg.shells.bash.enable;
      enableZshIntegration = cfg.shells.zsh.enable;
    };
  };
}
