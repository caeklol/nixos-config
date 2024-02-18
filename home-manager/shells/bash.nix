{
  config,
  lib,
  ...
}: let
  bash = config.modules.shells.bash;
in {
  options.modules.shells.bash = {
    enable = lib.mkEnableOption "enable bash";
  };

  config = lib.mkIf bash.enable {
    programs.bash = {
      enable = true;
    };
  };
}
