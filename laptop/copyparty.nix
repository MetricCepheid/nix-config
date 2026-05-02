# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  services.copyparty = {
    enable = true;
    settings = {
      p = [ 3210 ];
      xff-src = [
        "127.0.0.1"
        "::1"
      ];
      rproxy = 1;
    };
    accounts = {
      # replace this with your account
      metriccepheid = {
        passwordFile = "/etc/secrets/copyparty/metriccepheid";
      };
    };
    volumes = {
      # set up any volumes you'd like here
      "/music" = {
        path = "/mnt/externaldrive/Personal/Music";
        flags = {
          chmod_f = "644";
          chmod_d = "755";
        };
        access = {
          A = [ "metriccepheid" ];
          r = [ "*" ];
        };
      };
      "/general" = {
        path = "/mnt/externaldrive/Personal/General";
        flags = {
          chmod_f = "644";
          chmod_d = "755";
        };
        access = {
          A = [ "metriccepheid" ];
          r = [ "*" ];
        };
      };
    };
  };
}
