{
  config,
  pkgs,
  lib,
  ...
}: let
  remote = config.desktop.remote;
in {
  config = lib.mkIf remote {
    environment.systemPackages = with pkgs; [
      rustdesk
    ];

    services.rustdesk-server = {
      enable = true;
      openFirewall = true;
      signal.relayHosts = ["rs-ny.rustdesk.com"];
    };
  };
}
