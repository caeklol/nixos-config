# Most, if not all from:
# https://github.com/Misterio77/nix-starter-configs
{
  description = "caek's NixOS Config";

  inputs = {
    stable.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    agenix.url = "github:ryantm/agenix";

    xmrig-switch.url = "github:caeklol/xmrig-switch";
    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";

    apple-silicon.url = "github:tpwrules/nixos-apple-silicon";
    metasearch.url = "github:caeklol/metasearch2";
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
      "aarch64-linux"
      #"i686-linux"
      "x86_64-linux"
    ];

    forAllSystems = nixpkgs.lib.genAttrs systems;

    mkNixos = modules: hostname:
      nixpkgs.lib.nixosSystem {
        inherit modules;
        specialArgs = {inherit inputs outputs hostname;};
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
      desktop = mkNixos [./hosts/desktop/configuration.nix] "desktop";
      weirdleaf = mkNixos [./hosts/weirdleaf/configuration.nix] "weirdleaf";
    };

    homeConfigurations = {
      "caek@desktop" = mkHome [./hosts/desktop/home.nix] nixpkgs.legacyPackages.x86_64-linux;
      "caek@weirdleaf" = mkHome [./hosts/weirdleaf/home.nix] nixpkgs.legacyPackages.aarch64-linux;
    };
  };
}
