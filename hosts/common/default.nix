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
    ./ssh
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.stable-packages
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
#  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiSupport = true;


  system.stateVersion = "unstable";
}
