{ config, pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];
  #boot.kernelModules = [ "kvm-intel" "fuse" "reiser4" ];
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = [ "ntfs-3g" "reiser4"];
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

  time.timeZone = "Europe/Moscow";
  sound.enable = true;
  hardware = {
    #bluetooth.enable = true;
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = true;
    #cpu.amd.updateMicrocode = true;
    opengl.enable = true;
    opengl.driSupport = true;
    #opengl.driSupport32Bit = true;
    opengl.extraPackages = with pkgs; [ vaapiIntel libvdpau-va-gl vaapiVdpau ];
    #opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ vaapiIntel libvdpau-va-gl vaapiVdpau ];
    opengl.s3tcSupport = true;
    pulseaudio.enable = true;
    pulseaudio.package = pulseaudioFull;
    pulseaudio.systemWide = true;

  };
  i18n = {
    consoleFont = "UniCyr_8x16";
    consoleKeyMap = "ruwin_cplk-UTF-8";
    defaultLocale = "ru_RU.UTF-8";
    supportedLocales = [ "ru_RU.KOI8-R" "ru_RU/ISO-8859-5" "en_US.UTF-8" ];
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

  networking = {
    hostName = "ollerus";
    networkmanager.enable = true;
    #wireless.enable = true; # wpa
    #firewall.allowedTCPPorts = [ ... ];
    #firewall.allowedUDPPorts = [ ... ];
    #firewall.enable = false;
    #proxy.default = "http://user:password@proxy:port/";
    #proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

  system = { autoUpgrade.enable = true; stateVersion = "18.09"; };
  nixpkgs.config = { 
    allowBroken = true;
    allowUnfree = true;
    chromium.enablePepperFlash = true;
    chromium.enablePepperPDF = true;
    chromium.jre = true;
    chromium.enableAdobeFlash = true;
    firefox.enableAdobeFlash = true;
    firefox.enablePepperFlash = true;
    firefox.jre = true;
  };
  programs = {
    #gnupg.agent = {
    #  enable = true;
    #  enableSshSupport = true;
    #};
    #mtr.enable = true;
    #java.enable = true;
    #adb.enable = true;
    chromium.extensions = [ "cjpalhdlnbpafiamejdnhcphjbkeiagm" "bihmplhobchoageeokmgbdihknkjbknd" ];
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      interactiveShellInit = "ZSH_TMUX_AUTOSTART=true";
      ohMyZsh = {
        enable = true;
        theme = "bira";
        plugins = [ "git" "tmux" ];
      };
    };
  };

  environment.systemPackages = with pkgs; [ tmux mc unzip ntfs3g python2Full xarchiver
                                            gnupg gnupg1compat gitFull cmake gnumake gcc8 
                                            firefox vlc neofetch wget python3Full unar
                                            djview xpdf rsync ffmpeg-full python37Full
                                            chromium pavucontrol geany xfce.xfce4-xkb-plugin
                                            fuse appimage-run xfce.xfce4-pulseaudio-plugin
                                            xfce.xfce4-clipman-plugin bison flex openssl
                                            snappy libopus nss xorg.libxkbfile xorg.libXScrnSaver
                                            harfbuzzFull gtk2-x11 gnome2.gtk flac
                                            xdg_utils gparted acpi bc acpitool adobe-reader htop
                                            imagemagick speedcrunch links paprefs pasystray tor 
                                            torsocks torbrowser ];

  services.xserver.enable = true;
  services.xserver.layout = "us,ru";
  services.xserver.xkbOptions = "grp:caps_toggle,grp_led:num"; # scroll,num,caps
  #services.xserver.libinput.enable = true;
  services.xserver.desktopManager = { xfce.enable = true; default = "xfce"; };
  services.xserver.displayManager.auto = { enable = true; user = "obliq"; };
  services.xserver.videoDrivers = [ "intel" ];
  services.xserver.synaptics.enable = true;
  services.actkbd.enable = true;
  sound.mediaKeys.enable = true;
  services.compton.enable = true;
  services.compton.vSync = "opengl";
  #services.compton.shadow = true;
  #services.compton.menuOpacity = "0.9";
  #services.compton.shadowOpacity = "0.3";
  services.acpid.enable = true;
  services.tlp.enable = true;
  services.illum.enable = true;
  #services.printing.enable = true; # CUPS
  #services.openssh.enable = true;
  services.dbus.enable = true;
  services.dbus.packages = [ pkgs.gnome.GConf ];
  #services.cron.enable = true;
  #services.locate.enable = true;
  #services.udisks2.enable = true;
  #services.ntp.enable = true;
  services.tor.enable = true;

  users.extraGroups.pulse-access.members = [ "nick" "other" "guest" "root" "users" "wheel" ];
  users.extraGroups.audio.members = [ "nick" "other" "guest" "root" "users" "wheel" ];
  users.extraUsers.obliq = {
    isNormalUser = true;
    group = "users";
    uid = 1000;
    shell = pkgs.zsh;
    extraGroups = [ "audio" "docker" "pulse" "video" "wheel" "vboxusers" ];
  };
}
