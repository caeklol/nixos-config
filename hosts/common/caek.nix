{ pkgs, config, ... }:
{
  users.users.caek = {
	isNormalUser = true;
	description = "caek";
	extraGroups = [ "networkmanager" "wheel" ];
	packages = [ pkgs.home-manager];
	shell = pkgs.zsh;
  };
}
