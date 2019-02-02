{ config, pkgs, ... }:
{
   nix = { 
     gc.automatic = true;
     autoOptimiseStore = true;
     useSandbox = true;
     binaryCaches = [ "https://cache.nixos.org/" "https://emperes.cachix.org" ];
     binaryCachePublicKeys = [ "emperes.cachix.org-1:NsQvrJD2N3fR2501w6cEESFkUQbOjzpmpsX5tC/s+sI=" ];
     trustedUsers = [ "obliq" "root" ]; };
     
   nixpkgs.config = { allowBroken = true; allowUnfree = true; allowUnsupportedSystem = false; android_sdk.accept_license = true; };
   
   system = { 
    autoUpgrade.enable = false;
    stateVersion = "unstable";
    autoUpgrade.channel = https://nixos.org/channels/nixos-unstable; };
}
