{ pkgs, ... }:
let
    pkgs = import (builtins.fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/5a8650469a9f8a1958ff9373bd27fb8e54c4365d.tar.gz";
    }) {};

    myPkg = pkgs.mysql80;

    pkgs = import (builtins.fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/a5c9c6373aa35597cd5a17bc5c013ed0ca462cf0.tar.gz";
    }) {};

    myPkg = pkgs.php56;
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
  networking.networkmanager.enable = true;

  # sshd
  services.sshd.enable = true;
  services.openssh.settings.permitRootLogin = "yes";

  # system-wide packages
  environment.systemPackages = with pkgs; [
    neovim
  ];

  system.stateVersion = "23.11";
}
