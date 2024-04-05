{ config, lib, pkgs, ... }:

{
  imports = [
    <nixos-wsl/modules>
    ./package-versions/mysql.nix
    ./package-versions/php.nix
  ];

  wsl.enable = true;
  wsl.defaultUser = "nixos";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
    git
    neovim
  ];

  system.stateVersion = "23.11";
}