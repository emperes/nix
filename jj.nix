{ config, pkgs, ... }:
{ imports = [ ./hardware-configuration.nix ];
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";
  boot.kernelPackages = pkgs.linuxPackages_latest;
  networking.hostName = "ollerus";
  networking.networkmanager.enable = true;
  nix = { gc.automatic = true; autoOptimiseStore = true; useSandbox = true; };
  nixpkgs.config = { allowBroken = true; allowUnfree = true; };
  boot.kernelPatches = [ 
    { name = "reiser4";
      patch = ./reiser4-for-4.18.9.patch; }
    { name = "uksm";
      patch = ./uksm-4.18.patch; }
    { name = "muqss";
      patch = ./0001-MultiQueue-Skiplist-Scheduler-version-v0.173.patch;
      extraConfig = ''
        REISER4_FS y
        REISER4_DEBUG y
#       UKSM y
#       SCHED_MUQSS y
    '';
  } ];
  hardware = {
    enableRedistributableFirmware = true;
    enableAllFirmware = true;
    opengl.enable = true;
    opengl.driSupport = true;
    opengl.driSupport32Bit = true;
    opengl.extraPackages = with pkgs; [ vaapiIntel libvdpau-va-gl vaapiVdpau ];
    opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ vaapiIntel libvdpau-va-gl vaapiVdpau ];
    opengl.s3tcSupport = true;
    pulseaudio.enable = true;
    pulseaudio.support32Bit = true;
    pulseaudio.systemWide = true;
  };  
  i18n = {
    consoleFont = "UniCyr_8x16";
    consoleKeyMap = "ruwin_cplk-UTF-8";
    defaultLocale = "ru_RU.UTF-8";
    consoleColors = [ "1C1B19" "EF2F27" "519F50" "FBB829"
                      "2C78BF" "E02C6D" "0AAEB3" "918175"
                      "2D2C29" "F75341" "98BC37" "FED06E"
                      "68A8E4" "FF5C8F" "53FDE9" "FCE8C3" ];
  };
  fonts = {
    fonts = with pkgs; [ noto-fonts noto-fonts-emoji noto-fonts-extra noto-fonts-cjk liberation_ttf ];
    enableDefaultFonts = true;
    fontconfig.defaultFonts = {
      monospace = [ "Noto Mono" ];
      sansSerif = [ "Noto Sans" ];
      serif = [ "Noto Serif" ];
    };
  };
  time.timeZone = "Europe/Moscow";
  environment.systemPackages = with pkgs; [ gitFull geany xarchiver wget gcc xdg_utils cmake ncurses gparted acpi bc
                                            gnumake mc unzip reiser4progs pcmanfm-qt libaal bison flex openssl chromium ];
  sound.enable = true;
  services.xserver.enable = true;
  services.xserver.layout = "us,ru";
  services.xserver.xkbOptions = "grp:caps_toggle,grp_led:num"; # scroll,num,caps
  services.xserver.displayManager.auto = { enable = true; user = "obliq"; };
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.videoDrivers = [ "intel" ];
  services.xserver.synaptics.enable = true;
  services.compton.enable = true;
  services.compton.vSync = "opengl";
  services.dbus = { enable = true; packages = with pkgs; [ gnome2.GConf ]; };
  users.extraUsers.obliq = {
    isNormalUser = true;
    group = "users";
    uid = 1000;
    extraGroups = [ "audio" "pulse" "video" "wheel"];
  };
  systemd.services = {
    systemd-tmpfiles-setup.before = [ " sysinit.target " ];
    systemd-update-utmp.after = [ " systemd-tmpfiles-setup.service " ];
  };
  system.stateVersion = "18.09";
}
