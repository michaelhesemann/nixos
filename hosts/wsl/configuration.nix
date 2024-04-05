{ config, lib, pkgs, ... }:

{
  imports = [
    <nixos-wsl/modules>
  ];

  wsl.enable = true;
  wsl.defaultUser = "nixos";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
    git
    neovim
    btop
    htop
  ];

  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = true;

  programs.neovim.viAlias = true;
  programs.neovim.vimAlias = true;

  system.stateVersion = "23.11";
}