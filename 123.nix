{ config, pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";
  boot.kernelPackages = with pkgs.linuxPackages_custom.overrideDerivation (oldAttr: {
    version = "4.6.0-custom"; 
    src = pkgs.fetchurl { 
      url = "mirror://kernel/linux/kernel/v4.x/linux-4.6.tar.xz";
    };
  };  
  #environment.systemPackages = with pkgs; [ libaal reiser4progs ];
  system.stateVersion = "18.09";
}
