{ lib, callPackage }:

rec {
  frida = callPackage ./frida.nix { lib = mylib; };
  pycotap = callPackage ./pycotap {};
  pysol_cards = callPackage ./pysol_cards {};
}
