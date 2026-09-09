{ pkgs ? import <nixpkgs> {} }:

let
  # Includes common libraries needed by most modern Linux games
  runtimeLibs = with pkgs; [
    libGL
    libX11
    libXcursor
    libXrandr
    libXinerama
    libXi
    vulkan-loader
    alsa-lib
    libpulseaudio
    libepoxy
    libxext
    libXrender
    libXtst
    fontconfig
    freetype
  ];
in
pkgs.mkShell {
  name = "gaming-environment";

  # Build inputs make tools available in the $PATH
  buildInputs = with pkgs; [
    strace
    kdePackages.dolphin
    dejavu_fonts
    fontconfig
    (appimage-run.override {
      extraPkgs = pkgs: runtimeLibs;
    })
  ];

  # Maps standard game libraries into the dynamic linker path
  shellHook = ''
    export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath runtimeLibs}:$LD_LIBRARY_PATH"
    export FONTCONFIG_FILE="${pkgs.fontconfig.out}/etc/fonts/fonts.conf"
    export FONTCONFIG_PATH="${pkgs.fontconfig.out}/etc/fonts"
    export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=lcd"
    rm "/home/metriccepheid/.config/unity3d/srylain Inc_/Clone Hero/Player.log"
    rm "/home/metriccepheid/.config/unity3d/srylain Inc_/Clone Hero/Player-prev.log"
    cd "/home/metriccepheid/Games/CloneHero/INSTALL/Clone Hero"
    ./clonehero
  '';
}