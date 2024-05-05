{
  inputs,
  lib,
  ...
}: {
  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };

    # gc = {
    #   automatic = true;
    #   dates = "weekly";
    #   options = "--delete-older-than 1d";
    # };

    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;
    nixPath = ["nixpkgs=${inputs.nixpkgs.outPath}"];
  };

	programs.nh = {
    	enable = true;
    	clean.enable = true;
    	clean.extraArgs = "--keep-since 1d --keep 3";
    	flake = "/etc/nixos";
  	};
}
