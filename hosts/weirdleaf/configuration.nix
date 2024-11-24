{
  config,
  inputs,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./apple-silicon-support

    ../common
    ../common/networking.nix
  ];

  config = {
    powerManagement.enable = false;
    systemd = {
      targets = {
        sleep = {
          enable = false;
          unitConfig.DefaultDependencies = "no";
        };
        suspend = {
          enable = false;
          unitConfig.DefaultDependencies = "no";
        };
        hibernate = {
          enable = false;
          unitConfig.DefaultDependencies = "no";
        };
        "hybrid-sleep" = {
          enable = false;
          unitConfig.DefaultDependencies = "no";
        };
      };
    };

    hardware.asahi.peripheralFirmwareDirectory = ./firmware;

    age.secrets.ratholeCredentials.file = ../../secrets/rathole.toml.age;

    boot.loader.efi.canTouchEfiVariables = lib.mkForce false;
    boot.loader.grub.gfxmodeEfi = "3456x2160";
    services.rathole = {
      enable = false;
      role = "client";
      credentialsFile = config.age.secrets.ratholeCredentials.path;
    };
  };
}
