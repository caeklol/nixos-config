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

  services.printing.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true; # printing
  };

  hardware.enableRedistributableFirmware = true;
  security.rtkit.enable = true;
  #  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = lib.mkForce true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiSupport = true;
  boot.supportedFilesystems = ["ntfs"];

  systemd.services.NetworkManager-wait-online.enable = false;

  system.stateVersion = "unstable";
}
