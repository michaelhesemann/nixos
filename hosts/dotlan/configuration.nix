{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./package-versions/mysql.nix
    ./package-versions/php.nix
    ../../modules/locale.nix
    ../../modules/nix-ld.nix
    ../../modules/user-server.nix
  ];

  # basic stuff
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  networking.hostName = "dotlan";
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # sshd
  services.sshd.enable = true;

  # system-wide packages
  environment.systemPackages = with pkgs; [
    neovim
    git
    btop
    htop
  ];

  # networking
  networking.interfaces.ens33.ipv4.addresses = [{
    address = "10.20.0.103";
    prefixLength = 23;
  }];
  networking.defaultGateway = "10.20.0.1";
  networking.nameservers = ["10.20.0.102"];

  system.stateVersion = "23.11";
}
