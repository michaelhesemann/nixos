{ config, pkgs, ... }:
# let
#   phpPkgs = import (builtins.fetchTarball {
#       url = "https://github.com/NixOS/nixpkgs/archive/a5c9c6373aa35597cd5a17bc5c013ed0ca462cf0.tar.gz";
#       sha256 = "0wpl8rhkfd7s4nm32vfn6fha0g4a1p5214117vvwsl4y3l1gm68a";
#   }) {};

#   mysqlPkgs = import (builtins.fetchTarball {
#       url = "https://github.com/NixOS/nixpkgs/archive/5a8650469a9f8a1958ff9373bd27fb8e54c4365d.tar.gz";
#       sha256 = "";
#   }) {};
# in
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/locale.nix
    ../../modules/nix-ld.nix
    ../../modules/user-server.nix
  ];

  # basic stuff
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "dotlan";
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # sshd
  services.sshd.enable = true;
  # services.openssh.settings.permitRootLogin = "yes";

  # system-wide packages
  environment.systemPackages = with pkgs; [
    neovim
    # phpPkgs.php56
    # mysqlPkgs.mysql80
  ];

  # networking
  networking.interfaces.eth0.ipv4.addresses = [{
    address = "10.20.0.103";
    prefixLength = 23;
  }];
  networking.defaultGateway = "10.20.0.1";
  networking.nameservers = ["10.20.0.102"];

  system.stateVersion = "23.11";
}
