{...}: {
  services.resolved.enable = true;
  networking.firewall.checkReversePath = "loose";
  networking.iproute2.enable = true;
  networking.wireguard.enable = true;
  services.mullvad-vpn.enable = true;
}
