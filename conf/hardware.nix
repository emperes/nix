{ config, pkgs, ... }:
{
  hardware = {
    bluetooth.enable = false;
    
    enableRedistributableFirmware = true;
    enableAllFirmware = true;
    
    cpu = { intel.updateMicrocode = true; amd.updateMicrocode = false; };
    
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
    
  services = {
    actkbd.enable = true;
    xserver = { 
      videoDrivers = [ "intel" ];
      libinput.enable = true;
      synaptics = { 
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
	           Option "CircScrollDelta" "0.100007" ''; }; }; };

  sound = { enable = true; mediaKeys.enable = true; };
  
  powerManagement.cpuFreqGovernor = "performance";
  
  zramSwap = { enable = true; memoryPercent = 40; };
}
