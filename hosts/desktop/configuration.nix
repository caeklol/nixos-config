{...}: {
  imports = [
    ./hardware-configuration.nix

    ../common
    ../common/xmrig.nix
    ../common/mullvad.nix
    ../common/insomnia.nix
    ../common/networking.nix
    ../common/systemd-boot.nix
    ../common/virtualization.nix
    ../common/desktop
    ../common/desktop/audio.nix
    ../common/desktop/nvidia.nix
  ];

  config = {
    desktop = {
      remote = true;
      env = "gnome";
    };

    networking = {
      nameservers = ["1.1.1.1"];
    };
  };
}
