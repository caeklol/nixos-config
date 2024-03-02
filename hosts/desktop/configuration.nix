{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../common
    ../common/desktop
    ../common/desktop/audio.nix
    ../common/desktop/nvidia.nix
    ../common/desktop/gnome.nix
  ];

  networking = {
    hostName = "desktop";
    networkmanager.enable = true;
    nameservers = ["1.1.1.1"];
  };

services.xmrig = {
  enable = true;
  settings = {
    autosave = true;
    cpu = true;
    opencl = false;
    cuda = false;
    pools = [
      {
        url = "pool.supportxmr.com:443";
        user = "your-wallet";
        keepalive = true;
        tls = true;
      }
    ];
  };
  };
}
