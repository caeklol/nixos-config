let
  root = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPwNRkNryoGVDUYhtb6Crs22ydsiBXCRI69zWxzHXjXh root@weirdleaf";
in {
  "rathole.toml.age".publicKeys = [root];
}
