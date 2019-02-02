{ config, pkgs, ... }:
{
   nix = { gc.automatic = true; autoOptimiseStore = true; useSandbox = true; }; 
   nixpkgs.config = { allowBroken = true; allowUnfree = true; };
   system = { 
    autoUpgrade.enable = true;
    stateVersion = "unstable";
    autoUpgrade.channel = https://nixos.org/channels/nixos-unstable; };
