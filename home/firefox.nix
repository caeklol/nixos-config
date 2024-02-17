{ config, pkgs, ...}:
{
    programs.firefox = {
      enable = true;
      profiles = {
        default = {
          name = "Default";
	  #extensions = with nur.repos.rycee.firefox-addons; [
          #  bitwarden
          #  ublock-origin
	  #  darkreader
	  #];
        };
      };
    };
}
