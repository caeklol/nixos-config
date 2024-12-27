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

    inputs.metasearch.nixosModules.default
  ];


  config = {
    environment.systemPackages = with pkgs; [
      altserver-linux
    ];
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
      allowedTCPPorts = [22289];
      allowedUDPPorts = [53]; # dns is udp..
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
      openFirewall = true;
      settings = {
        dns = {
          upstream_dns = [
            "9.9.9.9"
            "149.112.112.112"
            # "127.0.0.1:5335"
          ];
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
    };

    #services.unbound = {
    #  enable = true;
    #  settings = {
    #    server = {
    #      interface = ["127.0.0.1"];
    #      port = 5335;
    #      access-control = ["127.0.0.1 allow"];
    #      harden-glue = true;
    #      harden-dnssec-stripped = true;
    #      use-caps-for-id = false;
    #      prefetch = true;
    #      edns-buffer-size = 1232;
    #      hide-identity = true;
    #      hide-version = true;
    #    };
    #    forward-zone = [
    #      {
    #        name = ".";
    #        forward-addr = [
    #          "9.9.9.9#dns.quad9.net"
    #          "149.112.112.112#dns.quad9.net"
    #        ];
    #        forward-tls-upstream = true;
    #      }
    #    ];
    #  };
    #};
  };
}
