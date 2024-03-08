{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    ../common
    ../common/nas.nix
    ../common/xmrig.nix
    ../common/desktop
    ../common/desktop/audio.nix
    ../common/desktop/nvidia.nix
  ];

  config = {
  	desktop = {
    	xrdp = true;
    	env = "i3"; # uM, ACtuAllY.......
    	            # i3 is a wInDow ManAgeR, whiCh You Can InStall OveR a DeSkTop EnvirOneMent..
    				# HoweVeRRRRRRRRRrr, a De Is not-
  };


  networking = {
    hostName = "desktop";
    nameservers = ["1.1.1.1"];
  };
      
  boot.loader.grub.gfxmodeEfi="1920x1080";

  };
}
