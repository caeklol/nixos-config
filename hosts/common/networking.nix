{lib, ...}: {
  networking.networkmanager.enable = true;
  networking.firewall = {
	enable = true;
	allowedTCPPorts = [ 22289 ]; # general purpose
  };
}
