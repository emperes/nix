{ config, pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];
  nixpkgs.config.packageOverrides = pkgs: { reiser4 = pkgs.reiser4.override { kernelPatches = [ { patch=/home/obliq/reiser4-for-4.18.0.patch; name="reiser4"; }  ]; }; };
  boot = { kernelModules = [ "reiser4" ]; supportedFilesystems = [ "reiser4" ]; loader.grub.enable = true; loader.grub.version = 2; loader.grub.device = "/dev/sda"; kernelPackages = pkgs.linuxPackages_custom { version = "4.18"; src = pkgs.fetchurl { url = "https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.18.tar.gz"; }; };
  environment.systemPackages = with pkgs; [ reiser4prog libaal ];
  system.stateVersion = "18.09"; # Did you read the comment?
}
