{
  stdenv,
  pkgs,
  fetchFromGitHub,
  autoreconfHook,
}:
stdenv.mkDerivation rec {
  pname = "xmrig-switch";
  version = "3";

  src = fetchFromGitHub {
    owner = "caeklol";
    repo = "xmrig-switch";
    rev = "master";
    hash = "sha256-mmTvaPb3POAHp6hEBUkZSl3SdvKV8CG5+pGQTsRCLJY=";
  };

  buildInputs = with pkgs; [
    systemdLibs
    libudev-zero
    pkg-config
  ];

  nativeBuildInputs = [autoreconfHook];

  meta = {
    description = "XMRig Switch controller binaries";
    mainProgram = "xmrig-switch";
  };
}
