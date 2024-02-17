{ config, pkgs, ...}:
{
  config = {
    home.packages = with pkgs; [
      (vscode-with-extensions.override {
        vscodeExtensions = with vscode-extensions; [
          golang.go
          rust-lang.rust-analyzer
        ];
      })
    ];
  };
}
