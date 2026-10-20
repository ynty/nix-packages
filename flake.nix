{
  description = "A very basic flake";

  inputs = {
    # nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";
    nixpkgs-unstable = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    herdr = {
      url = "github:herdrdev/herdr/v0.9.5";
      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
      };
    };

    pi-agent = {
      url = "github:earendil-works/pi/v1.3.0";
      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
      };
    };
  };

  outputs =
    inputs@{ nixpkgs-unstable, ... }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      forAllSystems = nixpkgs-unstable.lib.genAttrs systems;
    in
    {
      packages = forAllSystems (system: {
        herdr = import ./packages/herdr.nix { inherit inputs system; };
        pi-agent = import ./packages/pi-agent.nix { inherit inputs system; };
      });
    };
}
