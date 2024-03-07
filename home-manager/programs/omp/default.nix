{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules;
in {
  options.modules.programs.omp = {
    enable = lib.mkEnableOption "enable oh-my-posh";
  };

  config = lib.mkIf cfg.programs.omp.enable {
    programs.oh-my-posh = {
      enable = true;
      # useTheme = "huvix";
	  settings = builtins.fromJSON (builtins.unsafeDiscardStringContext (builtins.readFile ./theme.omp.json));
      enableBashIntegration = cfg.shells.bash.enable;
      enableZshIntegration = cfg.shells.zsh.enable;
    };
  };
}
