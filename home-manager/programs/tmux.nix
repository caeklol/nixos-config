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
			extraConfig = ''
				set-window-option -g window-status-current-style bg=FF0000	
			'';
		};
  	};
}
