{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-php-5-6-36.url = "https://github.com/NixOS/nixpkgs/archive/a5c9c6373aa35597cd5a17bc5c013ed0ca462cf0.tar.gz";
    nixpkgs-mysql-8-0-43.url = "https://github.com/NixOS/nixpkgs/archive/5a8650469a9f8a1958ff9373bd27fb8e54c4365d.tar.gz";
  };

  outputs = { self, nixpkgs, nixpkgs-php-5-6-36, nixpkgs-mysql-8-0-43, ... }@inputs:
    let
      system = "x86_64-linux";
      # pkgs = nixpkgs.legacyPackages.${system};
      overlay-nixpkgs = final: prev: {
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
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
      nixosConfigurations = {
        default = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [
            ./hosts/default/configuration.nix
          ];
        };
        laptop = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [
            ./hosts/laptop/configuration.nix
          ];
        };
        server = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [
            ./hosts/server/configuration.nix
          ];
        };
        dotlan = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [
            ./hosts/dotlan/configuration.nix
          ];
        };
        wsl = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {inherit inputs;};
          modules = [
            ({ config, pkgs, ... }: {
              nixpkgs.overlays = [ overlay-nixpkgs ];
            })
            ./hosts/wsl/configuration.nix
          ];
        };
      };
    };
}
