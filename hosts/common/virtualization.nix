{lib, ...}: {
	virtualisation = {
		libvirtd = {
			enable = true;
			qemu = {

			};
		};
		spiceUSBRedirection.enable = true;
	};

	services.spice-vdagentd.enable = true;
	programs.virt-manager.enable = true;
}
