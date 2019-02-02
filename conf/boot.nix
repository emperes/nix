{ config, pkgs, ... }:
{
   boot = {
    cleanTmpDir = true;
    kernelModules = [ "kvm-intel" "fuse" ]; #"reiser4" "spadfs" 
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = [ "ntfs-3g" ]; #"reiser4" "spadfs" 
    loader = {
      systemd-boot.enable = true;
      efi = { canTouchEfiVariables = true; efi.efiSysMountPoint = "/boot/efi"; };
      #grub = {
        #efiSupport = true;
        #efiInstallAsRemovable = true;
        #useOSProber = true;
        #enable = true;
        #version = 2;
        #device = "/dev/sdX";
   }; }; };
}
