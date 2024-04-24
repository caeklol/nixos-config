{
  config,
  lib,
  pkgs,
  ...
}: let
  virtualization = config.modules.virtualization;
in {
  options.modules.virtualization = {
    enable = lib.mkEnableOption "enable virtualization module with virt-manager";
  };

  config = lib.mkIf virtualization.enable {
	home.packages = with pkgs; [
		virt-manager
		virt-viewer
		spice
		spice-gtk
		spice-protocol
		win-virtio
		win-spice
	];

	dconf.settings = {
	  "org/virt-manager/virt-manager/connections" = {
		autoconnect = ["qemu:///system"];
		uris = ["qemu:///system"];
	  };
	};
  };
}
