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
    glib
    nss
    postgresql
    autoPatchelfHook
    libz
    libglvnd
    openal
    icu
    libice
    libsm
    ocamlPackages.ssl
    openssl_3
  ]) ++ (with pkgs.xorg; [
    libX11
    libXcursor
    libXrandr
    libXext
    libXtst
    libXi
    libXrender
    libXxf86vm
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
    glib
    nss
    postgresql
    autoPatchelfHook
    libz
    libglvnd
    openal
    icu
    libice
    libsm
    ocamlPackages.ssl
    openssl_3
  ]);
  runScript = "bash";
}).env
