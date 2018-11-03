{ config, pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";
  boot.kernelPackages = pkgs.linuxPackages_custom rec { 
    version = "4.18.0";
    configfile = /etc/nixos/kernel.config;
    src = pkgs.fetchurl {
      url = "https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.18.tar.xz";
      sha256 = "19d8bcf49ef530cd4e364a45b4a22fa70714b70349c8100e7308488e26f1eaf1";
    };
  };
  environment.systemPackages = with pkgs; [ libaal reiser4progs ];
  system.stateVersion = "18.09";
}
