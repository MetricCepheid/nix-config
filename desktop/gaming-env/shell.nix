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
  ];
in
pkgs.mkShell {
  name = "gaming-environment";

  # Build inputs make tools available in the $PATH
  buildInputs = with pkgs; [
    strace # Great for debugging missing libraries
    kdePackages.dolphin
    ];

  # Maps standard game libraries into the dynamic linker path
  shellHook = ''
    export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath runtimeLibs}:$LD_LIBRARY_PATH"
    rm "/home/metriccepheid/.config/unity3d/srylain Inc_/Clone Hero/Player.log"
    rm "/home/metriccepheid/.config/unity3d/srylain Inc_/Clone Hero/Player-prev.log"
    cd "/home/metriccepheid/Games/CloneHero"
    ./clonehero
  '';
}
