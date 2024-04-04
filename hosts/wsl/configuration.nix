{ config, lib, pkgs, ... }:

{
  imports = [
    <nixos-wsl/modules>
    ../../modules/user-server.nix
  ];

  wsl.enable = true;
  wsl.defaultUser = "nixos";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.nixPath = options.nix.nixPath.default ++ [ "nixpkgs-overlays=../../overlays" ];

  environment.systemPackages = with pkgs; [
    git
    neovim
    php
  ];

  system.stateVersion = "23.11";
}