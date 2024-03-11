{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/locale.nix
    ../../modules/nix-ld.nix
    ../../modules/x11.nix
    ../../modules/pipewire.nix
    ../../modules/docker.nix
    ../../modules/michael.nix
  ];

  # basic stuff
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "laptop";
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # cups and sshd
  services.printing.enable = true;
  services.sshd.enable = true;

  # system-wide packages
  environment.systemPackages = with pkgs; [
    wget
    htop
    btop
    tree
    ripgrep
    git
  ];

  system.stateVersion = "23.11";
}
