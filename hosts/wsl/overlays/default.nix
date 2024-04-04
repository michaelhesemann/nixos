# ./overlays/default.nix
{ config, pkgs, lib, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      php = prev.php.overrideAttrs (old: {
        src = prev.fetchurl {
          url = "https://github.com/NixOS/nixpkgs/archive/a5c9c6373aa35597cd5a17bc5c013ed0ca462cf0.tar.gz";
          sha256 = "0wpl8rhkfd7s4nm32vfn6fha0g4a1p5214117vvwsl4y3l1gm68a";
        };
      });
    })

    (final: prev: {
      mysql = prev.php.overrideAttrs (old: {
        src = prev.fetchurl {
          url = "https://github.com/NixOS/nixpkgs/archive/5a8650469a9f8a1958ff9373bd27fb8e54c4365d.tar.gz";
          sha256 = "0qij2z6fxlmy4y0zaa3hbza1r2pnyp48pwvfvba614mb8x233ywq";
        };
      });
    })
  ];
}