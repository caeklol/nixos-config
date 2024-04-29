{...}: {
  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
    powerOnBoot = true;
  };
  services.blueman.enable = true;
}
