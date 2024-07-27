{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  firefox = config.modules.browsers.firefox;
  nurNoPkgs = import inputs.nur {
    pkgs = pkgs;
    nurpkgs = pkgs;
  };
in {
  options.modules.browsers.firefox = {
    enable = lib.mkEnableOption "enable firefox";
  };

  config = lib.mkIf firefox.enable {
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

		  search = {
			engines = {
				"SearXNG" = {
					urls = [{ template = "https://priv.au/search?q={searchTerms}"; }];
				};
		  	};

			default = "SearXNG";
		  };
        };
      };
    };

    home.sessionVariables.BROWSER = "firefox";
  };
}
