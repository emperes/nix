{
  boot = {
    loader = {
      #efi.efiSysMountPoint = "/boot/efi";
      grub = {
        #efiSupport = true;
        #efiInstallAsRemovable = true;
        #useOSProber = true;
        enable = true;
        version = 2;
        device = "/dev/sda";
      };  
    };
  };
}
