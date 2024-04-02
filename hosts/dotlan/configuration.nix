{ pkgs, ... }:
let
  phpPkgs = import (builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/a5c9c6373aa35597cd5a17bc5c013ed0ca462cf0.tar.gz";
      sha256 = "aec0b610b9f6026c873f778a2e9c48ecfe84b7e1cba57015975176bfa4984379";
  }) {};

  mysqlPkgs = import (builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/5a8650469a9f8a1958ff9373bd27fb8e54c4365d.tar.gz";
      sha256 = "92639d1247beb37c6e3cbcf835fa69160fa72ed53ffce69c70c40b1b608c9ef3";
  }) {};
in
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
    phpPkgs.php56
    mysqlPkgs.mysql80
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
