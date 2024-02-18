{
  config,
  lib,
  pkgs,
  ...
}: let
  neovim = config.modules.editors.neovim;
in {
  options.modules.editors.neovim = {
    enable = lib.mkEnableOption "enable neovim";
  };

  config = lib.mkIf neovim.enable {
    programs.neovim = {
      enable = true;
      extraLuaConfig = ''
        vim.opt.tabstop = 4
        vim.opt.shiftwidth = 4
        vim.opt.expandtab = false
      '';
    };

    home.sessionVariables = {
      EDITOR = "nvim";
    };
  };
}
