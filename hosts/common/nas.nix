{config, ...}: {
  fileSystems."/run/media/dexterity" = {
    device = "192.168.1.87:/volume1/dexterity-shared";
    fsType = "nfs";
  };
}
