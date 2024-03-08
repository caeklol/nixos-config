{ config, lib, ... }: {
  imports = [
    ./xrdp.nix
    ./i3
  ];

  options.desktop.env = lib.mkOption {
	type = lib.types.str;
	description = "environment (choose between: i3, gnome)";
  };

  config = { 
   hardware = {
     opengl = {
       enable = true;
       driSupport = true;
       driSupport32Bit = true;
     };
   };
  };
}
