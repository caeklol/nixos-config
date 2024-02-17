{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
     ./tailscale.nix
     ./locale.nix
     ./caek.nix 
     ./nix.nix
     ./ssh.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];

    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  environment = {
	enableAllTerminfo = true;
	systemPackages = with pkgs; [
		vim
		git
	];
  };

  hardware.enableRedistributableFirmware = true;
  security.rtkit.enable = true;
  boot.loader.systemd-boot.enable = true;

  system.stateVersion = "23.11";
}
