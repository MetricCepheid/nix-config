{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
    nativeBuildInputs = [
      pkgs.pkg-config
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
      pkgs.sdl3
      pkgs.sndio
      pkgs.jack2
      pkgs.qtcreator
      pkgs.cmake
      pkgs.ninja
      pkgs.glew
      pkgs.openal
      pkgs.vulkan-validation-layers
      pkgs.udev
      pkgs.systemd
    ];
}
