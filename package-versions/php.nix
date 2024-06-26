{ config, pkgs, nixpkgs, ... }:

let
  pkgs = import (builtins.fetchGit {
    name = "php-5-6-36";
    url = "https://github.com/NixOS/nixpkgs/";
    ref = "refs/heads/nixpkgs-unstable";
    rev = "a5c9c6373aa35597cd5a17bc5c013ed0ca462cf0";
  }) { system = "x86_64-linux"; };

  php = pkgs.php56;
in

{
  environment.systemPackages = with pkgs; [
    php
  ];
}