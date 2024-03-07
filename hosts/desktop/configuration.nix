{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    ../common
    ../common/desktop
    ../common/nas.nix
    ../common/xmrig.nix
    ../common/desktop/audio.nix
    ../common/desktop/nvidia.nix
    ../common/desktop/i3.nix
  ];

  networking = {
    hostName = "desktop";
    networkmanager.enable = true;
    nameservers = ["1.1.1.1"];
  };
      
  boot.loader.grub.gfxmodeEfi="1920x1080";
}
