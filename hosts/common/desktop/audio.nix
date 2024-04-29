{
  config,
  pkgs,
  ...
}: {
  #hardware.pulseaudio = {
  #  enable = true;
  #  package = pkgs.pulseaudioFull;
  #  support32Bit = true; # Steam
  #  extraConfig = ''
  #    load-module module-bluetooth-policy auto_switch=2
  #  '';
  #};

  sound.enable = false;
  security.rtkit.enable = true;

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber = {
        enable = true;
        configPackages = [
          (pkgs.writeTextDir "share/wireplumber/bluetooth.lua.d/50-bluez.conf" ''
            monitor.bluez.rules = [
              {
                matches = [
                  {
                    ## This matches all bluetooth devices.
                    device.name = "~bluez_card.*"
                  }
                ]
                actions = {
                  update-props = {
                    bluez5.auto-connect = [ a2dp_sink ]
                    bluez5.hw-volume = [ a2dp_sink ]
                  }
                }
              }
            ]

            monitor.bluez.properties = {
              bluez5.roles = [ a2dp_sink ]
              bluez5.hfphsp-backend = "none"
            }
          '')
        ];
      };
    };
  };
}
