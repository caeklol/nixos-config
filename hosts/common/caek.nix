{
  pkgs,
  config,
  ...
}: {
  users.users.caek = {
    isNormalUser = true;
    description = "caek";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [
      home-manager
      vim
    ];
    shell = pkgs.bash;
    openssh.authorizedKeys.keyFiles = [
      ./ssh/authorized_keys
    ];
  };
}
