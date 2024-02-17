{ config, pkgs, inputs, ...}:
let 
    nurNoPkgs = import inputs.nur { pkgs = pkgs; nurpkgs = pkgs; };	    
in
{
    config = {
	    programs.firefox = {
	      enable = true;
	      profiles = {
		default = {
		  name = "Default";
		  extensions = with nurNoPkgs.repos.rycee.firefox-addons; [
		    bitwarden
		    ublock-origin
		    darkreader
		  ];
		};
	      };
	    };

    	   home.sessionVariables = {
    	     BROWSER = "firefox";
    	   };
    };
}
