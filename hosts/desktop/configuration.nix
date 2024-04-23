{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    ../common
    ../common/nas.nix
    ../common/xmrig.nix
    ../common/networking.nix
    ../common/desktop
    ../common/desktop/audio.nix
    ../common/desktop/nvidia.nix
  ];

  config = {
    desktop = {
      remote = true;
      env = "i3";
    };

    networking = {
      hostName = "desktop";
      nameservers = ["1.1.1.1"];
    };

    boot.loader.grub.gfxmodeEfi = "1920x1080";
  };
}
