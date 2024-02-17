{ config, pkgs, ... }: 
{
  imports = [
	./hardware-configuration.nix
	../common
	../common/desktop
	../common/desktop/audio.nix
	../common/desktop/nvidia.nix
	../common/optional/zsh.nix
  ];

  networking = {
	hostName = "desktop";
	networkmanager.enable = true;
	nameservers = [ "1.1.1.1" ];
  };

  environment = { 
	systemPackages = with pkgs; [
		vim
		git
	];
  };
}
