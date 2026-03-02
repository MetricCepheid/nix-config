# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./copyparty.nix
    ./yargspy.nix
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "mongodb-ce-8.0.4"
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.metriccepheid = {
    isNormalUser = true;
    description = "MetricCepheid";
    extraGroups = [
      "networkmanager"
      "wheel"
      "yargspy"
      "docker"
    ];
    packages = with pkgs; [
      kdePackages.kate
      pkgs.tcpdump
      #  thunderbird
    ];
  };
  users.users.goulart = {
    isNormalUser = true;
    home = "/home/goulart";
    description = "goulart";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
    mongosh
    mongodb-tools
    nodejs
    dotnetCorePackages.sdk_8_0_4xx-bin
    dotnetCorePackages.runtime_8_0-bin
    borgbackup
    openjdk
    git
    distrobox
    nixfmt-rfc-style
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "prohibit-password";
      AllowUsers = [
        "yargspy"
        "metriccepheid"
        "goulart"
        "root"
      ];
    };
  };

  services.udev = {
    enable = true;
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    22
    80
    443
    3000
    3210
    25565
  ];
  networking.firewall.allowedUDPPorts = [
    3000
    19132
    30066
  ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  # Nginx Configuration
  services.nginx = {
    enable = true;
    clientMaxBodySize = "65536m";

    virtualHosts."copyparty.metriccepheid.online" = {
      forceSSL = true;
      enableACME = true;
      locations."/" = {
        proxyWebsockets = true;
        proxyPass = "https://localhost:3210";
        recommendedProxySettings = true;
      };
    };

    virtualHosts."metriccepheid.online" = {
      forceSSL = true;
      enableACME = true;
      root = "/srv/metriccepheid.online";
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "rakleppen@gmail.com";
  };

  networking.nftables.enable = true;
  virtualisation.docker.enable = true;
}
