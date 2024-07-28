{
  config,
  pkgs,
  ...
}: {
  hardware.pulseaudio = {
    enable = false;
  };

  security.rtkit.enable = true;

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;

      # i agree with the following comment from:
      # https://github.com/TLATER/dotfiles/blob/master/nixos-config/default.nix
      #
      # Disable the HFP bluetooth profile, because I always use external
      # microphones anyway. It sucks and sometimes devices end up caught
      # in it even if I have another microphone.
      wireplumber.extraConfig = {
        "50-bluez" = {
          "monitor.bluez.rules" = [
            {
              matches = [{"device.name" = "~bluez_card.*";}];
              actions = {
                update-props = {
                  "bluez5.auto-connect" = [
                    "a2dp_sink"
                    "a2dp_source"
                  ];
                  "bluez5.hw-volume" = [
                    "a2dp_sink"
                    "a2dp_source"
                  ];
                };
              };
            }
          ];
          "monitor.bluez.properties" = {
            "bluez5.roles" = [
              "a2dp_sink"
              "a2dp_source"
              "bap_sink"
              "bap_source"
            ];

            "bluez5.codecs" = [
              "ldac"
              "aptx"
              "aptx_ll_duplex"
              "aptx_ll"
              "aptx_hd"
              "opus_05_pro"
              "opus_05_71"
              "opus_05_51"
              "opus_05"
              "opus_05_duplex"
              "aac"
              "sbc_xq"
            ];

            "bluez5.hfphsp-backend" = "none";
          };
        };
      };
    };

    #pipewire = {
    #  enable = true;
    #  alsa.enable = true;
    #  alsa.support32Bit = true;
    #  pulse.enable = true;
    #  wireplumber = {
    #    enable = true;
    #    configPackages = [
    #      (pkgs.writeTextDir "share/wireplumber/bluetooth.lua.d/50-bluez.conf" ''
    #        monitor.bluez.rules = [
    #          {
    #            matches = [
    #              {
    #                ## This matches all bluetooth devices.
    #                device.name = "~bluez_card.*"
    #              }
    #            ]
    #            actions = {
    #              update-props = {
    #                bluez5.auto-connect = [ a2dp_sink ]
    #                bluez5.hw-volume = [ a2dp_sink ]
    #              }
    #            }
    #          }
    #        ]
    #
    #        monitor.bluez.properties = {
    #          bluez5.roles = [ a2dp_sink ]
    #          bluez5.hfphsp-backend = "none"
    #        }
    #      '')
    #    ];
    #  };
    #};
  };
}
