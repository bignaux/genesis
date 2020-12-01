# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage

{ pkgs ? import <nixpkgs> {} }:
let
  maintainers = pkgs.lib.maintainers // import ./maintainers.nix;
  mylib = pkgs.lib // { maintainers = maintainers; };
in
# rec is pretty convinient...
rec {
  # The `lib`, `modules`, and `overlay` names are special
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  #appimage-run = pkgs.callPackage ./pkgs/tools/package-management/appimage-run {}; #82266 #89122
  #appimageTools = pkgs.callPackage ./pkgs/build-support/appimage {}; #82266

  assaultcube = pkgs.callPackage ./pkgs/assaultcube {};
  #beremiz = pkgs.callPackage ./pkgs/beremiz {};
  caprice32 = pkgs.callPackage ./pkgs/caprice32 {};
  clocktimer = pkgs.callPackage ./pkgs/clocktimer {};
  freediag = pkgs.callPackage ./pkgs/freediag {};
  frida-agent-example = pkgs.callPackage ./pkgs/frida-agent-example {};
  #frida-compile = pkgs.callPackage ./pkgs/frida-compile {};
  frida-tools = pkgs.callPackage ./pkgs/frida-tools { myPython3Packages = python3Packages; };
  gbdk-n = pkgs.callPackage ./pkgs/gbdk-n {};
  hdl-dump = pkgs.callPackage ./pkgs/hdl_dump {};

  # find a lot of games on https://itch.io/games/free/platform-linux
  hospital-hero = pkgs.callPackage ./pkgs/hospital-hero {};
  magick2cpc = pkgs.callPackage ./pkgs/magick2cpc {};
  matiec = pkgs.callPackage ./pkgs/matiec {};
  microwindows = pkgs.callPackage ./pkgs/microwindows {};
  mkpsxiso = pkgs.callPackage ./pkgs/mkpsxiso {};
  mymcplus = pkgs.python3Packages.callPackage ./pkgs/mymcplus {};
  navit = pkgs.libsForQt5.callPackage ./pkgs/navit {};
  #navittom = pkgs.callPackage ./pkgs/navittom {};
  nsntrace = pkgs.callPackage ./pkgs/nsntrace {};
  ntpbclient = pkgs.callPackage ./pkgs/ntpbclient {};
  pfsshell = pkgs.callPackage ./pkgs/pfsshell {};
  pysolfc = pkgs.callPackage ./pkgs/pysolfc { myPython3Packages = python3Packages; };

  python3Packages = pkgs.recurseIntoAttrs (
    pkgs.python3Packages.callPackage ./pkgs/development/python-modules {}
  );

  # from the makefile
  # -m32 because QuickBMS has been tested only on 32bit systems and gives problems using 64bit native code
  quickbms = pkgs.pkgsi686Linux.callPackage ./pkgs/quickbms {};
  rasm = pkgs.callPackage ./pkgs/rasm {};

  # qt.qpa.plugin issue, test later.
  #scriptcommunicator = pkgs.libsForQt5.callPackage ./pkgs/scriptcommunicator {};
  soulseekqt = pkgs.libsForQt5.callPackage ./pkgs/soulseekqt {};
  xlink-kai = pkgs.callPackage ./pkgs/xlink-kai { inherit frida-agent-example frida-tools; };
}
