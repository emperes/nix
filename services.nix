{
  services.xserver.enable = true;
  ##################################################
  #KEYBOARD                                        #
  services.xserver.xkbModel = "microsoft";         #
  services.xserver.xkbVariant = "winkeys";         #
  services.xserver.layout = "us,ru(winkeys)";      #
  services.xserver.xkbOptions = "grp:caps_toggle"; #
  ##################################################
  
  ##########################################
  #SYNAPTIC/TOUCHPAD                       #
  services.xserver.libinput.enable = true; #
  ##########################################
  
  ##############################################################
  #DE                                                          #
  services.xserver.desktopManager.lxqt.enable = true;          #
  services.xserver.desktopManager.default = "lxqt";            #
  ##############################################################
  
  ############################################################################
  #DM                                                                        #
  #services.xserver.displayManager.lightdm.enable = true;                    #     
  #services.xserver.displayManager.lightdm.autoLogin.enable = true;          #
  #services.xserver.displayManager.lightdm.autoLogin.user = "obliq";         #
  services.xserver.displayManager.auto = { enable = true; user = "obliq"; }; #
  ############################################################################
  
  ##############################################
  #GRAPHIC                                     #
  services.xserver.videoDrivers = [ "intel" ]; #
  services.compton.enable = true;              #
  services.compton.vSync = "opengl";           #
  services.compton.shadow = true;              #
  services.compton.menuOpacity = "0.9";        #
  services.compton.shadowOpacity = "0.3";      #
  ##############################################
  
  ###############################
  #LAPTOP                       #
  services.acpid.enable = true; #
  services.tlp.enable = true;   #
  services.illum.enable = true; #
  ###############################
  
  services.printing.enable = true; # CUPS
  services.openssh.enable = true;
  services.dbus.enable = true;
  services.cron.enable = true;
  services.locate.enable = true;
  services.udisks2.enable = true;
  services.ntp.enable = true;
  #services.nixosManual.showManual = true;
}
