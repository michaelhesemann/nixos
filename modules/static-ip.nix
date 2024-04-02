{ config, pkgs, lib, ... }:

with lib;

{
  options = {
    networking.staticIP.enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable static IP configuration";
    };

    networking.staticIP.interface = mkOption {
      type = types.str;
      default = "eth0";
      description = "Name of the network interface";
    };

    networking.staticIP.address = mkOption {
      type = types.str;
      default = "192.168.1.10";
      description = "Static IP address";
    };

    networking.staticIP.prefixLength = mkOption {
      type = types.int;
      default = 24;
      description = "Prefix length for the IP address";
    };

    networking.staticIP.gateway = mkOption {
      type = types.str;
      default = "192.168.1.1";
      description = "Gateway address";
    };

    networking.staticIP.dnsServers = mkOption {
      type = types.listOf types.str;
      default = ["8.8.8.8" "8.8.4.4"];
      description = "List of DNS servers";
    };
  };

  config = mkIf config.networking.staticIP.enable {
    networking.interfaces.${config.networking.staticIP.interface}.useDHCP = false;
    networking.interfaces.${config.networking.staticIP.interface}.ipv4.addresses = [{
      address = config.networking.staticIP.address;
      prefixLength = config.networking.staticIP.prefixLength;
    }];
    networking.interfaces.${config.networking.staticIP.interface}.ipv4.routes = [{
      address = "0.0.0.0";
      prefixLength = 0;
      via = config.networking.staticIP.gateway;
    }];
    networking.nameservers = config.networking.staticIP.dnsServers;
  };
}
