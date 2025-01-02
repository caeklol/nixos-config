{...}: {
  boot.loader.grub.gfxmodeEfi = "3456x2160";
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiSupport = true;
}
