{ pkgs ? import <nixpkgs> {} }:

(pkgs.buildFHSEnv {
  name = "simple-x11-env";
  targetPkgs = pkgs: (with pkgs; [
    udev
    alsa-lib
    zlib
    fuse
    libGL
    libfontenc
    pkg-config
    fontconfig
    freetype
    ftgl
    gperf
    pkgconf
    expat
    gmp
    gcc
    idris
  ]) ++ (with pkgs.xorg; [
    libX11
    libXcursor
    libXrandr
  ]);
  multiPkgs = pkgs: (with pkgs; [
    udev
    alsa-lib
    zlib
    fuse
    libGL
    libfontenc
    pkg-config
    fontconfig
    freetype
    ftgl
    gperf
    pkgconf
    expat
    gmp
    gcc
    idris
  ]);
  runScript = "bash";
}).env
