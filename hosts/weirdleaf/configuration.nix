{
  config,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    ../common
    ../common/grub.nix
    ../common/insomnia.nix
    ../common/networking.nix

    inputs.metasearch.nixosModules.default
    inputs.apple-silicon.nixosModules.default
    inputs.caek-dev.nixosModules.default
    inputs.nixarr.nixosModules.default
  ];

  config = {
    networking.firewall = {
      enable = true;
      allowedTCPPorts = [22289, 22270];
      allowedUDPPorts = [53]; # dns is udp..
    };
    hardware.asahi.peripheralFirmwareDirectory = ./firmware;

    age.secrets.ratholeCredentials.file = ../../secrets/rathole.toml.age;

    nixarr = {
	enable = true;
	mediaDir = "/data/media";
	stateDir = "/data/media/.state/nixarr";
	bazarr.enable = true;
	# lidarr.enable = true;
	prowlarr.enable = true;
	radarr.enable = true;
	readarr.enable = true;
	sonarr.enable = true;
	jellyseerr.enable = true;
    };

    services.rathole = {
      enable = true;
      role = "client";
      credentialsFile = config.age.secrets.ratholeCredentials.path;
      settings = {
        client = {
          remote_addr = "172.104.50.57:2333";
          services = {
            mc_java = {
              local_addr = "0.0.0.0:22291";
            };

            mc_bedrock = {
              local_addr = "0.0.0.0:19132";
	      type = "udp";
            };

            continental_mc = {
              local_addr = "0.0.0.0:22290";
            };

            continental_vc = {
              local_addr = "0.0.0.0:24454";
	      type = "udp";
            };

            rad2 = {
              local_addr = "0.0.0.0:22289";
            };

            rlcraft = {
              local_addr = "0.0.0.0:22269";
            };

            caek_dev_https = {
              local_addr = "0.0.0.0:443";
            };

            # let's encrypt
            caek_dev_http = {
              local_addr = "0.0.0.0:80";
            };
          };
        };
      };
    };
	boot.loader.grub.useOSProber = lib.mkForce false;

	services.caddy.virtualHosts = {
		"plex.caek.dev".extraConfig = ''
			reverse_proxy :32400
		'';

		"overseerr.caek.dev".extraConfig = ''
			reverse_proxy 192.168.2.123:5055

		'';
	};

    services.plex = {
      enable = true;
      openFirewall = true;
    };

    services.caddy.enable = true;

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
