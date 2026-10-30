{ inputs, system }:
let
  pkgs = inputs.nixpkgs-unstable.legacyPackages.${system};
in
  pkgs.pi-coding-agent
