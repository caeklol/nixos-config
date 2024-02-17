{
    outputs,
    lib,
    config,
    ...
}: {
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      StreamLocalBindUnlink = "yes";
      PasswordAuthentication = false;
    };
  };
}
