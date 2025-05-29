{
  inputs,
  outputs,
  lib,
  hostname,
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

    inputs.agenix.nixosModules.default
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.stable-packages

      inputs.agenix.overlays.default
    ];

    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  environment = {
    enableAllTerminfo = true;
    systemPackages = with pkgs; [
      agenix
      tmux
      vim
      git
    ];
    variables.EDITOR = "vim";
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true; # printing
  };

  networking.hostName = hostname;

  age.identityPaths = ["/root/.ssh/id_ed25519"];

  hardware.enableRedistributableFirmware = true;
  security.rtkit.enable = true;
  boot.supportedFilesystems = ["ntfs"];

  systemd.services.NetworkManager-wait-online.enable = false;

  system.stateVersion = "25.05";
}
