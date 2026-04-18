{ config, pkgs, ... }:

{
  users.users.yargspy = {
    isNormalUser = true;
    home = "/mnt/externaldrive/yargspy";
    description = "yargspy contained user";
  };

  users.users.yargspy.group = "yargspy";
  users.groups.yargspy = { };
  users.users.yargspy.homeMode = "711";

  systemd.services.yargspy = {
    enable = true;
    description = "YARGSpy Backend";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = ''${pkgs.nodejs}/bin/node /home/goulart/backend/index.js'';
      WorkingDirectory = ''/home/goulart/backend'';
      Restart = "on-failure";
      RestartSec = "3";
      RestartPreventExitStatus = "126";
      TimeoutStopSec = "90";
    };
  };

  # Nginx Configuration
  services.nginx = {
    virtualHosts."beta.yargspy.com" = {
      forceSSL = true;
      enableACME = true;
      root = "/mnt/externaldrive/yargspy/frontend";
    };

    virtualHosts."api.yargspy.com" = {
      forceSSL = true;
      enableACME = true;
      locations."/" = {
        recommendedProxySettings = true;
        proxyPass = "http://127.0.0.1:3000/";
      };
      extraConfig = ''
        client_max_body_size 32m;
      '';
    };
  };

  services.mongodb = {
      enable = true;
      package = pkgs.mongodb-ce;
      # enableAuth = true;
      # initialRootPasswordFile = /path/to/secure/passwordFile;
      bind_ip = "0.0.0.0";
      dbpath = "/mnt/externaldrive/yargspy/db";
  };
}
