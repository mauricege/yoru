{
  description = "Yoru (夜) Aesthetic and Beautiful Awesome Environment";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";

  outputs = { self, nixpkgs, flake-utils }@inputs:
    let
      overlays = [ (import ./overlay.nix) (import ./overrides.nix) ];
      composeOverlays = nixpkgs.lib.foldl' nixpkgs.lib.composeExtensions (final: prev: { });
    in
    (flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs { inherit system overlays; };
        in
        rec {
          packages = flake-utils.lib.filterPackages system
            (flake-utils.lib.flattenTree {
              inherit (pkgs.yoru) icomoon aesthetic-iosevka azuki aesthetic-night-gtk;
              inherit (pkgs) awesome;
            });
        }
      )) // {
      overlays = {
        default = composeOverlays overlays;
        yoru = import ./overlay.nix;
        awesome-git = import ./overrides.nix;
      };
      hmModule = import ./modules inputs;
    };
}
