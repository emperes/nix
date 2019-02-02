{ config, pkgs, ... }:
{
  hardware = {
    bluetooth.enable = false;
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = true;
    cpu.amd.updateMicrocode = false;
    enableAllFirmware = true;
    
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [ vaapiIntel libvdpau-va-gl vaapiVdpau ];
      extraPackages32 = with pkgs.pkgsi686Linux; [ vaapiIntel libvdpau-va-gl vaapiVdpau ];
      s3tcSupport = true; };
      
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
      support32Bit = true;
      systemWide = true; }; };
    
  services.xserver.libinput.enable = true;
  services.xserver.synaptics = { 
    enable = false;
    accelFactor = "0.0350939";
    vertEdgeScroll = false;
    horizEdgeScroll = false;
    additionalOptions = ''
	       Option "LTCornerButton" "2"
	       Option "RTCornerButton" "3"
	       Option "TapAndDragGesture" "1"
	       Option "CircularScrolling" "1"
	       Option "CircScrollTrigger" "3"
	       Option "CircScrollDelta" "0.100007" ''; };
  
  services.actkbd.enable = true;
  services.xserver.videoDrivers = [ "intel" ];
  
  sound = { enable = true; mediaKeys.enable = true; };
  
  powerManagement.cpuFreqGovernor = "performance";
  
  zramSwap = { enable = true; memoryPercent = 40; };
}
