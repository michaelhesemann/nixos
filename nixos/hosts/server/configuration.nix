{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/main-user.nix
    ../../modules/locale.nix
    ../../modules/nix-ld.nix
  ];

  # basic stuff
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "server";
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  networking.networkmanager.enable = true;

  # sshd
  services.sshd.enable = true;

  # system-wide packages
  environment.systemPackages = with pkgs; [
    neovim
  ];

  # users
  main-user.enable = true;
  main-user.userName = "michael";

  system.stateVersion = "23.11";
}
