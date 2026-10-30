{
  description = "Nix software packages that I used in my systems.";

  inputs = {
    # nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";
    nixpkgs-unstable = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
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
