{ config, pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";
  networking = { hostName = "ollerus"; networkmanager.enable = true; };
  time.timeZone = "Europe/Moscow";
  environment.systemPackages = with pkgs; [ xfce.xfce4-xkb-plugin firefox ];
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  i18n = { consoleFont = "UniCyr_8x16"; consoleKeyMap = "ruwin_cplk-UTF-8"; defaultLocale = "ru_RU.UTF-8"; };
  fonts = { fonts = with pkgs; [ noto-fonts noto-fonts-emoji noto-fonts-extra noto-fonts-cjk ]; enableDefaultFonts = true; fontconfig.defaultFonts = { monospace = [ "Noto Mono" ]; sansSerif = [ "Noto Sans" ]; serif = [ "Noto Serif" ]; };
  services.xserver.enable = true;
  services.xserver.xkbModel = "microsoft";
  services.xserver.xkbVariant = "winkeys";
  services.xserver.layout = "us,ru(winkeys)";
  services.xserver.xkbOptions = "grp:caps_toggle";
  services.xserver.desktopManager = { xfce.enable = true; default = "xfce"; };
  services.xserver.displayManager.auto = { enable = true; user = "obliq"; };
  users.users.obliq = { isNormalUser = true; uid = 1000; };
  system.stateVersion = "18.09";
}
