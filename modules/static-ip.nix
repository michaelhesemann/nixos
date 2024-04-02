{ config, lib, ... }:

with lib;

{
  options = {
    networking.interfaces.eth0.useDHCP = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to use DHCP for eth0 interface";
    };

    networking.interfaces.eth0.ipv4.addresses = mkOption {
      type = types.listOf types.attrs;
      default = [];
      description = "List of IPv4 addresses for eth0 interface";
    };

    networking.defaultGateway = mkOption {
      type = types.str;
      default = "";
      description = "Default gateway IP address";
    };

    networking.nameservers = mkOption {
      type = types.listOf types.str;
      default = [];
      description = "List of DNS server IP addresses";
    };
  };

  config = {
    networking.interfaces.eth0.useDHCP = config.networking.interfaces.eth0.useDHCP;
    networking.interfaces.eth0.ipv4.addresses = config.networking.interfaces.eth0.ipv4.addresses;
    networking.defaultGateway = config.networking.defaultGateway;
    networking.nameservers = config.networking.nameservers;
  };
}
