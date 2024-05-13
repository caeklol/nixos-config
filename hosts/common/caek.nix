{
  pkgs,
  config,
  ...
}: {
  users.users.caek = {
    isNormalUser = true;
    description = "caek";
    extraGroups = ["networkmanager" "wheel" "libvirtd" "dialout"];
    packages = with pkgs; [
      home-manager
      vim
    ];
    shell = pkgs.bashInteractive;
    openssh.authorizedKeys.keyFiles = [
      ./ssh/authorized_keys
    ];
  };

  nix.settings.trusted-users = ["root" "caek"];
}
