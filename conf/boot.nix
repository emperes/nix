{ config, pkgs, ... }:
{
   boot = {
    blacklistedKernelModules = [ "snd_pcsp" "pcspkr" ];
    cleanTmpDir = true;
    kernelModules = [ "kvm-intel" "fuse" ];
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = [ "ntfs-3g" ];
    loader = { systemd-boot.enable = true; efi.canTouchEfiVariables = true; };
      #efi.efiSysMountPoint = "/boot/efi";
      #grub = {
        #efiSupport = true;
        #efiInstallAsRemovable = true;
        #useOSProber = true;
        #enable = true;
        #version = 2;
        #device = "/dev/sdX"; }; 
   };
}
