{ config, pkgs, nixpkgs, ... }:

let
  pkgs = import fetchGit (system = "x86_64-linux"; builtins.fetchGit {
    name = "mysql-8-0-34";
    url = "https://github.com/NixOS/nixpkgs/";
    ref = "refs/heads/nixpkgs-unstable";
    rev = "9957cd48326fe8dbd52fdc50dd2502307f188b0d";
  }) {};

  mysql = pkgs.mysql80;
in

{
  environment.systemPackages = with pkgs; [
    mysql
  ];
}
