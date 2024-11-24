let
  root = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILvu7MdKek+7oZJ85o1CnkhEtCNqAkHM/0LDG6tUevks root@weirdleaf";
in {
  "rathole.toml.age".publicKeys = [root];
}
