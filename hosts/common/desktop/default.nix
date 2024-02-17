{ config, ... }:
{
   hardware = {
  	  opengl = {
		  enable = true;
		  driSupport = true;
		  driSupport32Bit = true;
	  };
  };

   services = {
	xserver = {
		desktopManager.gnome.enable = true;
		displayManager.gdm.enable = true;

		enable = true;
    		layout = "us";
    		xkbVariant = "";
  	};
   };
}
