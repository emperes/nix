}
  networking = { hostName = "ollerus"; networkmanager.enable = true; #wireless.enable = true;
    #firewall = {
      #allowedTCPPorts = [ ... ];
      #allowedUDPPorts = [ ... ];
      #enable = false;
    #};  
    #proxy = {
      #default = "http://user:password@proxy:port/";
      #noProxy = "127.0.0.1,localhost,internal.domain";
    #};  
  };
}  
