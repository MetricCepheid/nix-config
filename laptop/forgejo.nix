{ lib, pkgs, config, ... }:
let
  cfg = config.services.forgejo;
  srv = cfg.settings.server;
in
{
  services.nginx = {
    virtualHosts."git.metriccepheid.online" = {
      forceSSL = true;
      enableACME = true;
      extraConfig = ''
        client_max_body_size 512M;
      '';
      locations."/".proxyPass = "http://localhost:3000";
    };
  };

  services.forgejo = {
    enable = true;
    database.type = "postgres";
    # Enable support for Git Large File Storage
    lfs.enable = false;
    settings = {
      server = {
        DOMAIN = "git.metriccepheid.online";
        # You need to specify this to remove the port from URLs in the web UI.
        ROOT_URL = "https://git.metriccepheid.online/"; 
        HTTP_PORT = 3000;
      };
      # You can temporarily allow registration to create an admin user.
      service.DISABLE_REGISTRATION = true; 
      # Add support for actions, based on act: https://github.com/nektos/act
      actions = {
        ENABLED = false;
        DEFAULT_ACTIONS_URL = "github";
      };
    };
  };
}
