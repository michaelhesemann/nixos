{ pkgs, ... }:
let
  phpPkgs = import (builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/a5c9c6373aa35597cd5a17bc5c013ed0ca462cf0.tar.gz";
  }) {};

  mysqlPkgs = import (builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/5a8650469a9f8a1958ff9373bd27fb8e54c4365d.tar.gz";
  }) {};
in
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/locale.nix
    ../../modules/nix-ld.nix
    ../../modules/user-server.nix
    ../../modules/static-ip.nix
  ];

  # basic stuff
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "dotlan";
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # sshd
  services.sshd.enable = true;
  services.openssh.settings.permitRootLogin = "yes";

  # system-wide packages
  environment.systemPackages = with pkgs; [
    neovim
    phpPkgs.php56
    mysqlPkgs.mysql80
  ];

  # networking
  networking.staticIP.enable = true;
  networking.staticIP.interface = "eth0";
  networking.staticIP.address = "10.20.0.103";
  networking.staticIP.prefixLength = 23;
  networking.staticIP.gateway = "10.20.0.1";
  networking.staticIP.dnsServers = ["10.20.0.102"];

  system.stateVersion = "23.11";
}
