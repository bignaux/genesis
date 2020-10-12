{ callPackage }:

rec {

  pycotap = callPackage ./pycotap {};

  pysol_cards = callPackage ./pkgs/pysol_cards {};
}
