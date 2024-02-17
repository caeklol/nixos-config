{ config, pkgs, ... }:
{
  config = {

	home.packages = with pkgs; [
		fd
	];

 	programs.fzf = {
		enable = true;
		defaultCommand = "${pkgs.fd}/bin/fd -E node_modules/ --type directory";
		changeDirWidgetCommand = "${pkgs.fd}/bin/fd -E node_modules/ --type directory";
		enableBashIntegration = true;
	};
  };
}
