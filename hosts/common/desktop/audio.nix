{config, pkgs, ...}: {
  #hardware.pulseaudio = {
  #  enable = true;
  #  package = pkgs.pulseaudioFull;
  #  support32Bit = true; # Steam
  #  extraConfig = ''
  #    load-module module-bluetooth-policy auto_switch=2
  #  '';
  #};
  
  sound.enable = true;
  security.rtkit.enable = true;


  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
  };
}
