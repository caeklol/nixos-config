{
  config,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./apple-silicon-support

    ../common
    ../common/grub.nix
    ../common/insomnia.nix
    ../common/networking.nix

    inputs.metasearch.nixosModules.default
  ];

  config = {
    networking.firewall = {
      enable = true;
      allowedTCPPorts = [22289];
      allowedUDPPorts = [53]; # dns is udp..
    };
    hardware.asahi.peripheralFirmwareDirectory = ./firmware;

    age.secrets.ratholeCredentials.file = ../../secrets/rathole.toml.age;

    services.rathole = {
      enable = true;
      role = "client";
      credentialsFile = config.age.secrets.ratholeCredentials.path;
      settings = {
        client = {
          remote_addr = "172.233.75.141:2333";
          services = {
            minecraft_building = {
              local_addr = "0.0.0.0:22289";
            };
          };
        };
      };
    };

    services.adguardhome = {
      enable = true;
      openFirewall = true;
      settings = {
        enable_dnssec = false;
        dns = {
          upstream_dns = [
            "127.0.0.1:5335"
          ];
          cache_size = 0;
        };
        filtering = {
          protection_enabled = true;
          filtering_enabled = true;

          parental_enabled = false;
          safe_search.enabled = false;
        };
      };
    };

    services.syncthing.enable = true;
    services.metasearch = {
      enable = true;
      openFirewall = true;
      settings = {
        image_search.enabled = true;
        urls.replace = {
          "www.reddit.com" = "old.reddit.com";
          "medium.com" = "scribe.rip";
          ".medium.com" = "scribe.rip";
        };

        engines = {
          brave = {
            enabled = true;
            weight = 0.1;
          };

          bing = false;
          marginalia = false;
        };
      };
    };

    services.unbound = {
      enable = true;
      settings = {
        server = {
          interface = ["127.0.0.1"];
          port = 5335;
          access-control = ["127.0.0.1 allow"];
          harden-glue = true;
          harden-dnssec-stripped = true;
          use-caps-for-id = false;
          prefetch = true;
          edns-buffer-size = 1232;
          hide-identity = true;
          hide-version = true;
        };
        forward-zone = [
          {
            name = ".";
            forward-addr = [
              "9.9.9.9#dns.quad9.net"
              "149.112.112.112#dns.quad9.net"
            ];
            forward-tls-upstream = true;
          }
        ];
      };
    };
  };
}
