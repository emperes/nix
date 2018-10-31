{ config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
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
    opengl.enable = true;
    opengl.driSupport = true;
    opengl.driSupport32Bit = true;
    opengl.extraPackages = with pkgs; [ vaapiIntel libvdpau-va-gl vaapiVdpau ];
    opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ vaapiIntel libvdpau-va-gl vaapiVdpau ];
    opengl.s3tcSupport = true;
    pulseaudio = { enable = true; package = pkgs.pulseaudioFull; extraConfig = ''load-module module-switch-on-connect''; };
  };

  i18n = {
    consoleFont = "UniCyr_8x16";
    consoleKeyMap = "ruwin_cplk-UTF-8";
    defaultLocale = "ru_RU.UTF-8";
    consoleColors = [ "161616" "a65353" "909653" "bd9c5a" "5f788c" "816b87" "688c88" "c5c5c5"
                      "4a4a4a" "cc6666" "b5bd68" "f0c674" "81a2be" "b294bb" "8abeb7" "f7f7f7" ];
  };
  fonts = {
    fonts = with pkgs; [ noto-fonts noto-fonts-emoji noto-fonts-extra noto-fonts-cjk ];
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
  nixpkgs.config = { allowBroken = true; allowUnfree = true; };
  programs = {
    #gnupg.agent = {
    #  enable = true;
    #  enableSshSupport = true;
    #};
    #mtr.enable = true;
    rootston.enable = true;
    sway.enable = true;
    java.enable = true;
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
  environment.systemPackages = with pkgs; [ tmux mc unzip ntfs3g xarchiver
                                            gnupg gnupg1compat gitFull cmake gnumake gcc 
                                            firefox vlc screenfetch neofetch wget
                                            djview xpdf rsync ffmpeg-full python37Full
                                            chromium pavucontrol pasystray paprefs ];

 services.xserver.enable = true;
  services.xserver.xkbModel = "microsoft";
  services.xserver.xkbVariant = "winkeys";
  services.xserver.layout = "us,ru(winkeys)";
  services.xserver.xkbOptions = "grp:caps_toggle";
  services.xserver.libinput.enable = true;
  services.xserver.desktopManager = { lxqt.enable = true; default = "lxqt"; };
  services.xserver.displayManager.auto = { enable = true; user = "obliq"; };
  services.xserver.videoDrivers = [ "intel" ];
  services.compton.enable = true;
  services.compton.vSync = "opengl";
  services.compton.shadow = true;
  services.compton.menuOpacity = "0.9";
  services.compton.shadowOpacity = "0.3";
  services.acpid.enable = true;
  services.tlp.enable = true;
  services.illum.enable = true;
  services.printing.enable = true; # CUPS
  services.openssh.enable = true;
  services.dbus.enable = true;
  services.cron.enable = true;
  services.locate.enable = true;
  services.udisks2.enable = true;
  services.ntp.enable = true;
  #services.nixosManual.showManual = true;
  environment.lxqt.excludePackages = with pkgs.lxqt; [ compton-conf lxqt-about lxqt-notificationd lxqt-runner pavucontrol-qt
                                                        libfm-qt lxqt-admin lxqt-openssh-askpass lxqt-session pcmanfm-qt
                                                        liblxqt lxqt-build-tools lxqt-panel lxqt-sudo qlipper
                                                        libqtxdg lxqt-config lxqt-policykit lxqt-themes qps screengrab
                                                        libsysstat lxqt-globalkeys lxqt-powermanagement qterminal
                                                        lximage-qt lxqt-l10n lxqt-qtplugin obconf-qt qtermwidget ];

  users.extraUsers.obliq = {
    isNormalUser = true;
    name = "obliq";
    group = "users";
    uid = 1000;
    shell = pkgs.zsh;
    extraGroups = [
      "dialout" "plugdev" "audio" 
      "video" "disk" "libvirtd"
      "networkmanager" "systemd-journal" 
      "wheel" "adb" "power" "vboxusers" 
    ];
    createHome = true;
    home = "/home/obliq";
  };
}
