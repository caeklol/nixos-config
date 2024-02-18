{ config, lib, pkgs, ... }:
{

	config = {
		programs.git = {
			enable = true;
			userName = "caeklol";
			userEmail = "me@caek.dev";
		};
    	};
}
