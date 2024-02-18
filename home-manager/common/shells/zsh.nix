{
  config,
  lib,
  ...
}: let
  zsh = config.modules.shells.zsh;
in {
  options.modules.shells.zsh = {
    enable = lib.mkEnableOption "enable zsh";
  };

  config = lib.mkIf zsh.enable {
    programs.zsh = {
      enable = true;
      initExtra = ''
        bindkey "^[[1;5C" forward-word
        bindkey "^[[1;5D" backward-word
        bindkey "^[[1;6C" vi-forward-word
        bindkey "^[[1;6D" vi-backward-word
      '';
    };
  };
}
