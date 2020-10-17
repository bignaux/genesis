{ pkgs, stdenv, fetchurl, patchelf }:

let
  nur = import (builtins.fetchTarball
    "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };

  version = "7.4.38";

in stdenv.mkDerivation rec{
  pname = "xlink-kai";
  packages = with pkgs; [ nur.repos.mic92.frida-tools ];
  inherit version;

  src = fetchurl {
    url = "https://github.com/Team-XLink/releases/releases/download/v7.4.38/kaiEngine-7.4.38-539579851.headless.ubuntu.x86_64.tar.gz";
    sha256 = "0k2b7g3vm81dpr08kjsv7g85l4brljywv1gy7dm41v0z87vzi52r";
  };

  # avoid dynamic fetching by kaiEngine
  # TODO : copy that to be available in a wrapper
  /* webui = fetchurl {
    name = "webui.zip";
    url = "https://client.teamxlink.co.uk/binary/webui_0.9978-38.zip";
    sha256 = "625662901391a70213680c5e59baffc495f8d95596cb620ac5e9eb42a833dd51";
  }; */

  nativeBuildInputs = [ patchelf ];
  buildInputs = [ nur.repos.mic92.frida-tools ];

  phases = [ "unpackPhase" "installPhase" ];

  installPhase = ''

    patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" kaiengine
    patchelf --set-rpath "$p:${stdenv.lib.makeLibraryPath [ stdenv.cc.cc ]}" kaiengine
  # To run without root/sudo grant cap_net_admin capability to the engine with:
  # TODO : write wrapper with libcap
  # setcap cap_net_admin=eip kaiengine
    install -Dm755 kaiengine $out/bin/kaiengine
    #install -Dm644 "${webui}" $out/data/webui.zip

    # we need same libc as frida python
    # patchelf --print-rpath <somepython> */
  '';

  # we have to catch interruption and resume process.
  # frida ./kaiengine -l interrupt.js --no-pause -q

  meta = with stdenv.lib; {
    broken = true;
    description = "tunneling program that allows the play LAN games online";
    homepage = https://www.teamxlink.co.uk;
    license = licenses.unfree;
    maintainers = with maintainers; [ genesis ];
    platforms = [ "x86_64-linux" ];
  };
}
