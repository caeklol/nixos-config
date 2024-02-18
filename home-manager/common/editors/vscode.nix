{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules;
in {
  options.modules.editors.vscode = {
    enable = lib.mkEnableOption "enable vscode";
  };

  config = lib.mkIf cfg.editors.vscode.enable {
    home.packages = with pkgs; [
      (vscode-with-extensions.override {
        vscodeExtensions = with vscode-extensions; [
          golang.go
          rust-lang.rust-analyzer
          vscodevim.vim
        ];
      })
    ];
  };
}
