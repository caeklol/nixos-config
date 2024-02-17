{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
     inputs.home-manager.nixosModules.home-manager
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
    };
  };

  environment.enableAllTerminfo = true;
  hardware.enableRedistributableFirmware = true;
  security.rtkit.enable = true;
  boot.loader.systemd-boot.enable = true;

  system.stateVersion = "23.11";
}
