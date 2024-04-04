{ pkgs ? import <nixpkgs> {} }:

let
  fetchurl = pkgs.fetchurl;
in

{
  nixpkgs.overlays = [
    (self: super: {
      php = super.php.overrideAttrs (oldAttrs: {
        version = "5.6.36";
        src = fetchurl {
          url = "https://github.com/NixOS/nixpkgs/archive/a5c9c6373aa35597cd5a17bc5c013ed0ca462cf0.tar.gz";
          sha256 = "0wpl8rhkfd7s4nm32vfn6fha0g4a1p5214117vvwsl4y3l1gm68a";
        };
      });
    })
  ];
}
