{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./apple-silicon-support

    ../common
  ];

  config = {
  boot.loader.efi.canTouchEfiVariables = lib.mkForce false;

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

    boot.loader.grub.gfxmodeEfi = "3456x2160";
  };
}
