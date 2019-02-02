{ config, pkgs, ... }:
{
  hardware = {
    bluetooth.enable = false;
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = true;
    cpu.amd.updateMicrocode = false;
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
    
  services.xserver.libinput.enable = true;
  services.xserver.synaptics.enable = false;
  services.actkbd.enable = true;
  sound = { enable = true; mediaKeys.enable = true; };
}
