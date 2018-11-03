{ config, pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";
  linuxPackages = #pkgs.linuxPackages_4_6;
  boot.kernelPackages = with pkgs.linuxPackages_custom.overrideDerivation (oldAttr: {
    version = "4.6.0-custom";
    src = pkgs.fetchurl {
      url = "mirror://kernel/linux/kernel/v4.x/linux-4.6.tar.xz";
      sha256 = "0rnq4lnz1qsx86msd9pj5cx8v97yim9l14ifyac7gllabb6p2dx9";
    };  
  };
  environment.systemPackages = with pkgs; [ libaal reiser4progs ];
  system.stateVersion = "18.09";
}
