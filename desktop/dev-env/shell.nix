{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
    nativeBuildInputs = [
      pkgs.pkg-config
      pkgs.cmake
    ];
    buildInputs = [
      pkgs.qt6.qtbase
      pkgs.qt6.qtwebengine
      pkgs.qt6.qttools
      pkgs.qt6.qtdeclarative
      pkgs.qt6.qt5compat
      pkgs.qt6.qtwebchannel
      pkgs.qt6.qtpositioning
      pkgs.qt6.qtsvg
      pkgs.SDL2
      pkgs.sndio
      pkgs.jack2
      pkgs.qtcreator
      pkgs.ninja
      pkgs.glew
      pkgs.openal
      pkgs.vulkan-validation-layers
      pkgs.udev
      pkgs.systemd
      pkgs.pkgconf
      pkgs.python3
      pkgs.freetype
      pkgs.glm
      pkgs.stb
      pkgs.gettext
      pkgs.fmt
    ];
  shellHook = ''
    export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath [ pkgs.SDL2 pkgs.SDL2_image pkgs.SDL2_ttf pkgs.SDL2_mixer ]}:$LD_LIBRARY_PATH"
  '';
}
