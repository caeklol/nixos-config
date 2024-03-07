{ config, ... }:
{
	fileSystems."/run/media/dexterity" = {
		device = "dexterity:/volume1/dexterity-shared"; 
		fsType = "nfs"; 
	}; 
}
