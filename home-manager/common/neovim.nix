{ config, pkgs, ...}:
{
    config = {
	    programs.neovim = {
	      enable = true;
	    };

    	   home.sessionVariables = {
    	     EDITOR = "nvim";
    	   };
    };
}
