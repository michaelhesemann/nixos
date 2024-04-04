{ config, pkgs, lib, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      php = prev.php.overrideAttrs (old: {
        src = prev.fetchurl {
          url = "https://github.com/NixOS/nixpkgs/archive/a5c9c6373aa35597cd5a17bc5c013ed0ca462cf0.tar.gz";
          sha256 = "rsC2ELn2AmyHP3eKLpxI7P6Et+HLpXAVl1F2v6SYQ3k=";
        };
      });
    })

    (final: prev: {
      mysql = prev.php.overrideAttrs (old: {
        src = prev.fetchurl {
          url = "https://github.com/NixOS/nixpkgs/archive/5a8650469a9f8a1958ff9373bd27fb8e54c4365d.tar.gz";
          sha256 = "kmOdEke+s3xuPLz4NfppFg+nLtU//OaccMQLG2CMnvM=";
        };
      });
    })
  ];
}