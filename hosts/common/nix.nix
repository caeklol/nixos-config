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

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1d";
    };

    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;
    nixPath = ["nixpkgs=${inputs.nixpkgs.outPath}"];
  };

  programs.nh = {
    enable = true;
    flake = "/etc/nixos";
  };
}
