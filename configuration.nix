{ config, pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];
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
    #bluetooth.enable = true;
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = true;
    #cpu.amd.updateMicrocode = true;
    opengl.enable = true;
    opengl.driSupport = true;
    opengl.driSupport32Bit = true;
    opengl.extraPackages = with pkgs; [ vaapiIntel libvdpau-va-gl vaapiVdpau ];
    opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ vaapiIntel libvdpau-va-gl vaapiVdpau ];
    opengl.s3tcSupport = true;
    pulseaudio = { 
      enable = true; 
      package = pkgs.pulseaudioFull.override { jackaudioSupport = true; }; 
      extraConfig = ''load-module module-switch-on-connect'';
      support32Bit = true;
    };  
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
    adb.enable = true;
    documentation.info.enable = true;
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
  environment.systemPackages = with pkgs; [ tmux mc unzip ntfs3g python2Full mate.engrampa
                                            gnupg gnupg1compat gitFull cmake gnumake gcc 
                                            firefox vlc neofetch wget python3Full unar
                                            djview xpdf rsync ffmpeg-full python37Full
                                            chromium pavucontrol pasystray paprefs
                                            
                                            #XFCE
                                            albatross elementary-xfce-icon-theme xfce4-13.exo
                                            xfce4-13.garcon xfce4-13.gigolo greybird
                                            xfce4-13.gtk-xfce-engine xfce.gvfs xfce4-13.automakeAddFlags
                                            indicator-application-gtk2 xfce4-13.libxfce4ui
                                            xfce4-13.libxfce4util lxtask xfce4-13.mousepad
                                            numix-gtk-theme xfce4-13.orage xfce4-13.parole
                                            plano-theme xfce4-13.ristretto xfce4-13.thunar
                                            xfce4-13.tumbler xfce4-13.xfburn xfce4-13.xfce4-appfinder
                                            xfce4-13.xfce4-battery-plugin xfce4-13.xfce4-clipman-plugin
                                            xfce4-13.xfce4-cpufreq-plugin xfce.xfce4-cpugraph-plugin
                                            xfce.xfce4-datetime-plugin xfce4-13.xfce4-dev-tools
                                            xfce4-13.xfce4-dict xfce4-13.xfce4-dockbarx-plugin
                                            xfce4-13.xfce4-embed-plugin xfce.xfce4-eyes-plugin
                                            xfce.xfce4-fsguard-plugin xfce.xfce4-genmon-plugin
                                            xfce4-13.xfce4-hardware-monitor-plugin xfce4-13.xfce4-icon-theme
                                            xfce.xfce4-mailwatch-plugin xfce4-13.xfce4-mixer
                                            xfce.xfce4-mpc-plugin xfce4-13.xfce4-namebar-plugin
                                            xfce4-13.xfce4-netload-plugin xfce4-13.xfce4-notifyd
                                            xfce4-13.xfce4-panel xfce4-13.xfce4-power-manager
                                            xfce4-13.xfce4-pulseaudio-plugin xfce4-13.xfce4-screenshooter
                                            xfce.xfce4-sensors-plugin xfce4-13.xfce4-session
                                            xfce4-13.xfce4-settings xfce.xfce4-systemload-plugin
                                            xfce4-13.xfce4-taskmanager xfce4-13.xfce4-terminal
                                            xfce.xfce4-timer-plugin xfce.xfce4-vala-panel-appmenu-plugin
                                            xfce.xfce4-verve-plugin xfce.xfce4-volumed
                                            xfce4-13.xfce4-volumed-pulse xfce.xfce4-weather-plugin
                                            xfce4-13.xfce4-whiskermenu-plugin xfce4-13.xfce4-windowck-plugin
                                            xfce4-13.xfce4-xkb-plugin xfce4-13.xfconf
                                            xfce4-13.xfdesktop xfce4-13.xfwm4 xfce4-13.xfwm4-themes];

  services.xserver.enable = true;
  services.xserver.xkbModel = "microsoft";
  services.xserver.xkbVariant = "winkeys";
  services.xserver.layout = "us,ru(winkeys)";
  services.xserver.xkbOptions = "grp:caps_toggle";
  services.xserver.libinput.enable = true;
  services.xserver.desktopManager = { xfce.enable = true; default = "xfce";
                                      xfce.thunarPlugins = [ pkgs.xfce.thunar-archive-plugin
                                                             pkgs.xfce4-13.thunar-volman 
                                                             pkgs.xfce.thunar-dropbox-plugin ]; };
  services.xserver.displayManager.auto = { enable = true; user = "obliq"; };
  services.xserver.videoDrivers = [ "intel" ];
  services.actkbd.enable = true;
  sound.mediaKeys.enable = true;
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
