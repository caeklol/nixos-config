{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  ungoogled = config.modules.browsers.ungoogled;
  nurNoPkgs = import inputs.nur {
    pkgs = pkgs;
    nurpkgs = pkgs;
  };
in {
  options.modules.browsers.ungoogled = {
    enable = lib.mkEnableOption "enable ungoogled";
  };

  config = lib.mkIf ungoogled.enable {
  	programs.chromium = {
		enable = true;
		package = pkgs.ungoogled-chromium;
	};
  };
}
