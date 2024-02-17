{ config, pkgs, ...}:
{
   config = {
	   programs.kitty = {
	      enable = true;
	      font = {
		package = (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; });
		name = "JetBrains Mono Nerd Font";
		size = 13;
	      };
	      shellIntegration = {
		enableBashIntegration = true;
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
