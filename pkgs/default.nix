# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
{ pkgs ? (import ../nixpkgs.nix) {} }:
{
  apple-fonts = pkgs.callPackage ./apple-fonts.nix {};
  xmrig-switch = pkgs.callPackage ./xmrig-switch.nix {};
}
