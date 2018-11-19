{ config, pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];
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
  zramSwap = { enable = true; memoryPercent = 50; };
  #powerManagement.cpuFreqGovernor = "performance";
  time.timeZone = "Europe/Moscow";
  sound.enable = true;
  hardware = {
    bluetooth.enable = true;
    enableRedistributableFirmware = true;
    #cpu.intel.updateMicrocode = true;
    #cpu.amd.updateMicrocode = true;
    enableAllFirmware = true;
    opengl.enable = true;
    opengl.driSupport = true;
    opengl.driSupport32Bit = true;
    opengl.extraPackages = with pkgs; [ vaapiIntel libvdpau-va-gl vaapiVdpau ];
    opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ vaapiIntel libvdpau-va-gl vaapiVdpau ];
    opengl.s3tcSupport = true;
    pulseaudio.enable = true;
    pulseaudio.support32Bit = true;
    pulseaudio.systemWide = true; };
  i18n = {
    consoleFont = "UniCyr_8x16";
    consoleKeyMap = "ruwin_cplk-UTF-8";
    defaultLocale = "ru_RU.UTF-8";
    consoleColors = [ "1C1B19" "EF2F27" "519F50" "FBB829"
                      "2C78BF" "E02C6D" "0AAEB3" "918175"
                      "2D2C29" "F75341" "98BC37" "FED06E"
                      "68A8E4" "FF5C8F" "53FDE9" "FCE8C3" ]; };
