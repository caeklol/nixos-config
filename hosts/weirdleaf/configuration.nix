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

    networking.firewall = {
      enable = true;
      allowedTCPPorts = [3000 53 22289];
    };
    hardware.asahi.peripheralFirmwareDirectory = ./firmware;

    age.secrets.ratholeCredentials.file = ../../secrets/rathole.toml.age;

    boot.loader.efi.canTouchEfiVariables = lib.mkForce false;
    boot.loader.grub.gfxmodeEfi = "3456x2160";
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
      settings = {
        http = {
          # You can select any ip and port, just make sure to open firewalls where needed
          address = "127.0.0.1:3000";
        };
        dns = {
          upstream_dns = [
            # Example config with quad9
            # "9.9.9.9#dns.quad9.net"
            # "149.112.112.112#dns.quad9.net"
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
