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

    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;
    nixPath = ["nixpkgs=${inputs.nixpkgs.outPath}"];
  };

  programs.nh = {
    enable = true;
    clean.enable = false;
    flake = "/etc/nixos";
  };
}
