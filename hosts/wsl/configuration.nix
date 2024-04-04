{ config, lib, pkgs, ... }:

{
  inputs = {
    nixpkgs-php-5-6-36.url = "https://github.com/NixOS/nixpkgs/archive/a5c9c6373aa35597cd5a17bc5c013ed0ca462cf0.tar.gz";
    nixpkgs-mysql-8-0-43.url = "https://github.com/NixOS/nixpkgs/archive/5a8650469a9f8a1958ff9373bd27fb8e54c4365d.tar.gz";
  };

  outputs = { self, nixpkgs-php-5-6-36, nixpkgs-mysql-8-0-43, ... }@inputs:
    let
      overlay-nixpkgs = final: prev: {
        php-5-6-36 = import nixpkgs-php-5-6-36 {
          inherit system;
          config.allowUnfree = true;
        };
        mysql-8-0-43 = import nixpkgs-mysql-8-0-43 {
          inherit system;
          config.allowUnfree = true;
        };
      };
    in
    {
      environment.systemPackages = with pkgs; [
        git
        neovim
        nixpkgs-php-5-6-36.php
        nixpkgs-mysql-8-0-43.mysql
      ];
    };

  imports = [
    <nixos-wsl/modules>
  ];

  wsl.enable = true;
  wsl.defaultUser = "nixos";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "23.11";
}