# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage

{ pkgs ? import <nixpkgs> {} }:

{
  # The `lib`, `modules`, and `overlay` names are special
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  assaultcube = pkgs.callPackage ./pkgs/assaultcube {};
  caprice32 = pkgs.callPackage ./pkgs/caprice32 {};
  freediag = pkgs.callPackage ./pkgs/freediag {};
  gbdk-n = pkgs.callPackage ./pkgs/gbdk-n {};
  hdl-dump = pkgs.callPackage ./pkgs/hdl_dump {};

  magick2cpc = pkgs.callPackage ./pkgs/magick2cpc {};
  mkpsxiso = pkgs.callPackage ./pkgs/mkpsxiso {};
  mymcplus = pkgs.python3Packages.callPackage ./pkgs/mymcplus {};
  navit = pkgs.libsForQt5.callPackage ./pkgs/navit {};
  ntpbclient = pkgs.callPackage ./pkgs/ntpbclient {};
  pfsshell = pkgs.callPackage ./pkgs/pfsshell {};

  #pysolfc = pkgs.callPackage ./pkgs/pysolfc
  #  {
      # myPython3Packages = python3Packages;
  #  };

  python3Packages = pkgs.recurseIntoAttrs (
    pkgs.python3Packages.callPackage ./pkgs/development/python-modules {}
  );

  #quickbms = pkgs.callPackage ./pkgs/quickbms {}; #81023
  rasm = pkgs.callPackage ./pkgs/rasm {};

  # qt.qpa.plugin issue, test later.
  #scriptcommunicator = pkgs.libsForQt5.callPackage ./pkgs/scriptcommunicator {};

  xlinkkai = pkgs.callPackage ./pkgs/xlinkkai {};
}
