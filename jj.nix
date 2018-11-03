{ config, pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];
  nixpkgs.overlays = [ (self: super: {
    buildLinux = (cfg: super.buildLinux rec {
    version = "4.19";
    modDirVersion = "4.19.0";
    extraMeta.branch = "4.19";
    src = super.fetchurl {
      url = "mirror://kernel/linux/kernel/v4.x/linux-${version}.tar.xz";
      sha256 = "18a92z17alh5kkvjv7l9z8wk5jgdb6raawdfkpwx9bi8amjzas0c";
    };
    ignoreConfigErrors = true;
    extraConfig = cfg;
    kernelPatches = with super.kernelPatches; [
      bridge_stp_helper
      modinst_arg_list_too_long
    ];
  });
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";
  boot.kernelPackages = pkgs.linuxPackages_custom rec { 
    version = "4.18";
    src = pkgs.fetchurl {
      url = "https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.18.tar.xz";
      sha256 = "19d8bcf49ef530cd4e364a45b4a22fa70714b70349c8100e7308488e26f1eaf1";
    };
    configfile = /etc/nixos/kernel.config;
  };
  environment.systemPackages = with pkgs; [ libaal reiser4progs ];
  system.stateVersion = "unstable";
}
