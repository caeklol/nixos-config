{ config, pkgs, ... }:
{
  config = {
     programs.oh-my-posh = {
        enable = true;
        useTheme = "catppuccin_mocha";
        enableBashIntegration = true;
     };
  };
}
