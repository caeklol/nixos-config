{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    ../common
    ../common/xmrig.nix
    ../common/mullvad.nix
    ../common/networking.nix
    ../common/virtualization.nix
    ../common/desktop
    ../common/desktop/audio.nix
    ../common/desktop/nvidia.nix
  ];

  config = {
    desktop = {
      remote = true;
      env = "hyprland";
    };

    networking = {
      nameservers = ["1.1.1.1"];
    };

    boot.loader.grub.gfxmodeEfi = "2560x1440";

    nixpkgs.config.permittedInsecurePackages = [
      "cinny-4.2.3"
    ];
  };
}
