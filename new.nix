{ config, pkgs, ... }:
{
  imports = [ ]
  boot = {
    cleanTmpDir = true;
    kernelModules = [ "kvm-intel" "fuse" ];
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = [ "ntfs-3g" ];
    loader = {
      #efi.efiSysMountPoint = "/boot/efi";
      grub = {
        #efiSupport = true;
        #efiInstallAsRemovable = true;
        #useOSProber = true;
        enable = true;
        version = 2;
        device = "/dev/sda"; }; }; };
}
