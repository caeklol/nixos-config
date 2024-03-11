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
  configJson = builtins.toJSON miner_cfg;
  configFile = pkgs.writeText "config.json" configJson;
in {
  config = {
    hardware.cpu.x86.msr.enable = true;

    systemd.services.xmrig = {
      wantedBy = lib.mkForce [];
      after = ["network.target"];
      description = "XMRig Mining Software Service (no auto-start)";
      serviceConfig = {
        ExecStartPre = "${lib.getExe pkgs.xmrig} --config=${configFile} --dry-run";
        ExecStart = "${lib.getExe pkgs.xmrig} --config=${configFile}";
        DynamicUser = false;
      };
    };
  };
}
