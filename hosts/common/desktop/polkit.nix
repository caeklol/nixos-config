{
  pkgs,
  lib,
  ...
}: {
  config = {
    environment.systemPackages = with pkgs; [
      lxqt.lxqt-policykit
    ];

    security.polkit.enable = true;
  };
}
