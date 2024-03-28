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
      shellAliases = {
        stopwatch = "date1=`date +%s`; while true; do echo -ne \"\$(date -u --date @\$((`date +%s` - $date1)) +%H:%M:%S)\\r\"; done";
      };
    };
  };
}
