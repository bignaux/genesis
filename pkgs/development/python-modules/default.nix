{ lib, callPackage }:

rec {

  pycotap = callPackage ./pycotap {};
  pysol_cards = callPackage ./pysol_cards {};
  frida = callPackage ./frida.nix {};
}
