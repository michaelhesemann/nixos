{ pkgs, ... }:

{
  # enable dynamic libs
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # add dynamic libs here
  ];
}
