{
  config,
  pkgs,
  lib,
  ...
}: let
  miner_cfg = {
    autosave = true;
    cpu = true;
    opencl = false;
    cuda = false;
    pools = [
      {
        algo = null;
        coin = "monero";
        # feel free to mine for me lmao
        url = "stratum+tcp://randomxmonero.auto.nicehash.com:9200";
        user = "37YsYDMqbyJ2BdAGZ95FHWNYLa9UiBmMWN.nixos";
        pass = null;
        rig-id = null;
        nicehash = true;
        keepalive = true;
        enabled = true;
        tls = false;
        tls-fingerprint = null;
        daemon = false;
        self-select = null;
      }
    ];
  };
  config_json = builtins.toJSON miner_cfg;
  xmrig = config.modules.programs.xmrig;
in {
  options.modules.programs.xmrig = {
    enable = lib.mkEnableOption "enable xmrig miner";
  };

  config = lib.mkIf xmrig.enable {
    home.packages = [
      pkgs.xmrig
    ];

    home.file.".xmrig.json".text = config_json;
  };
}
