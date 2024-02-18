{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../common
    ../common/unfree.nix
    ../common/desktop
    ../common/desktop/audio.nix
    ../common/desktop/nvidia.nix
  ];

  networking = {
    hostName = "desktop";
    networkmanager.enable = true;
    nameservers = ["1.1.1.1"];
  };
}
