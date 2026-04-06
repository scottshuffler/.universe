# Builds a standalone home-manager configuration for non-NixOS, non-darwin
# hosts (e.g., stock Ubuntu) where we only manage the user environment via
# home-manager, not the full system.
#
# Host files use the same attr-set pattern as mksystem.nix but only `system`,
# `user`, `home`, and optionally `homie` are used — `systemConfig` and
# `diskConfig` are ignored.
{ inputs }:

hostname:
let
  nixpkgs = inputs.nixpkgs;
  lib = nixpkgs.lib;

  hostFile =
    if builtins.pathExists ../hosts/${hostname}.nix then
      ../hosts/${hostname}.nix
    else
      ../hosts/${hostname}/default.nix;
  hostConfig = import hostFile;

  currentSystem = hostConfig.system;
  user = hostConfig.user;

  pkgs = nixpkgs.legacyPackages.${currentSystem};

  specialArgs = {
    inherit
      currentSystem
      hostname
      user
      inputs
      ;
  };
in
inputs.home-manager.lib.homeManagerConfiguration {
  inherit pkgs;
  extraSpecialArgs = specialArgs;
  modules = [
    hostConfig.home or { }
    hostConfig.homie.home or { }
    {
      home.username = user;
      home.homeDirectory = "/home/${user}";
    }
  ];
}
