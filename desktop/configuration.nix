{ inputs, config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  zramSwap.enable = true;

  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 16384;
  }];

  networking.hostName = "nixos-desktop"; # Define your hostname.
  networking.networkmanager.enable = true;

  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  services.flatpak.enable = true;

  programs.noisetorch.enable = true;

  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };

  services.tailscale = {
    enable = true;
  };

  users.users.metriccepheid = {
    isNormalUser = true;
    description = "metriccepheid";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
     dolphin-emu              # Nintendo Wii™️ Emulator
     prismlauncher            # minecraft
     qpwgraph                 # pipewire graph manager
     rpcs3                    # Playstation 3™️ Emulator
     audacity                 # audio editor
     dotnetCorePackages.sdk_8_0_4xx-bin
     dotnetCorePackages.runtime_8_0-bin
     discord-ptb              # fuckass app to talk to weird people
     fish                     # meow
     git                      # version control system
     inputs.waterfox.packages.${pkgs.system}.waterfox-bin # web browser
     mpv                      # video player
     keepassxc                # password keeper client
     kdePackages.kdenlive     # video editor
     kdePackages.kcalc        # caluclaotr
     #krita                   # duplicate image editor for some fucking reason
     rclone                   # outright fucking awesome file-syncing client
     filezilla                # outright fucking awful ftp client
     appimage-run             # container for running 
     wineWow64Packages.stable # wine but 64-bit
     fastfetch                # like neofetch but less ableist
     protontricks             # easy proton(wine) settings
     qbittorrent              # torrenter
     freetype                 # font thing
     nix-index
     # teamspeak3 - needs qtwebengine, fuck that lol (flatpak it is)
     handbrake                # video compressor
     krita                    # image editor
     file                     # gives you the metadata of a specified file
     p7zip                    # 7zip but p
     htop                     # cli task manager
     cmake
     pkg-config
     #qt6.qtbase
     #qt6.qttools
     #qt6.qtwayland
     #qtcreator
     wget                     # internet file downloader
     zenity                   # gtk dialog thing
     winetricks               # easy wine settings
     ffmpeg                   # cli audio/video/subtitle/metadata editor
     easyeffects              # Voice changer
     imhex                    # Hex Editing
     (python3.withPackages ( ps: with ps; [ # Eventually replace
         numpy
         torch
         soundfile
     ]))
     (pkgs.wrapOBS { # Recording/Streaming software
        plugins = with pkgs.obs-studio-plugins; [
          wlrobs
          obs-backgroundremoval
          obs-pipewire-audio-capture
        ];
      })
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
