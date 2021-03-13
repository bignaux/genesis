{ callPackage }:

rec {

  pycotap = callPackage ./pycotap { lib = mylib; };
  pysol_cards = callPackage ./pysol_cards { lib = mylib; };
  frida = callPackage ./frida.nix { lib = mylib; };
}
