# Most, if not all from:
# https://github.com/Misterio77/nix-starter-configs
{
  description = "caek's NixOS Config";

  inputs = {
    stable.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    xmrig-switch.url = "github:caeklol/xmrig-switch";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";
  };

  outputs = {
    self,
    nixpkgs,
    stable,
    home-manager,
    nur,
    ...
  } @ inputs: let
    inherit (self) outputs;
    systems = [
      #"aarch64-linux"
      #"i686-linux"
      "x86_64-linux"
    ];

    forAllSystems = nixpkgs.lib.genAttrs systems;

    mkNixos = modules:
      nixpkgs.lib.nixosSystem {
        inherit modules;
        specialArgs = {inherit inputs outputs;};
      };

    mkHome = modules: pkgs:
      home-manager.lib.homeManagerConfiguration {
        inherit modules pkgs;
        extraSpecialArgs = {inherit inputs outputs;};
      };
  in {
    packages = forAllSystems (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        import ./pkgs {inherit pkgs;}
    );
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    overlays = import ./overlays {inherit inputs;};

    nixosConfigurations = {
      desktop = mkNixos [./hosts/desktop/configuration.nix];
    };

    homeConfigurations = {
      "caek@desktop" = mkHome [./hosts/desktop/home.nix] nixpkgs.legacyPackages.x86_64-linux;
    };
  };
}
