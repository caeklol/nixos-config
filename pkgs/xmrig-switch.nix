{
  stdenv,
  pkgs,
  fetchFromGitHub,
  autoreconfHook,
}:
stdenv.mkDerivation rec {
  pname = "xmrig-switch";
  version = "2";

  src = fetchFromGitHub {
    owner = "caeklol";
    repo = "xmrig-switch";
    rev = "master";
    hash = "sha256-5S0XvH0pE8n5rX+wU1A1vgvd2Fnb4qPEbyWKi7fMWNQ=";
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
