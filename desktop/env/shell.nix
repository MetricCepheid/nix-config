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
    dotnetCorePackages.dotnet_8.sdk
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
    dotnetCorePackages.dotnet_8.sdk
  ]);
  
  LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";

  runScript = "bash";
}).env
