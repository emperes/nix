{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  #boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda"; # or "nodev" for efi only
    #efiSupport = true;
    #efiInstallAsRemovable = true;
  };  
  
  hardware ={
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [ vaapiIntel libvdpau-va-gl vaapiVdpau ];
      extraPackages32 = with pkgs.pkgsi686Linux; [ vaapiIntel libvdpau-va-gl vaapiVdpau ];
      s3tcSupport = true;
  };

  networking = {
    hostName = "ollerus"; # Define your hostname.
    networkmanager.enable = true;
    #wireless.enable = true;  # wpa_supplicant
    #firewall.allowedTCPPorts = [ ... ];
    #firewall.allowedUDPPorts = [ ... ];
    #firewall.enable = false;
    proxy = {
      default = "http://user:password@proxy:port/";
      noProxy = "127.0.0.1,localhost,internal.domain";
    }; 
  };

  # Enable unfree packages.
  nixpkgs.config.allowUnfree = true;
  chromium.enablePepperFlash = true;
  
  programs = {
    #gnupg.agent = {
    #  enable = true;
    #  enableSshSupport = true;
    #};
    #mtr.enable = true;
    java.enable = true;
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      interactiveShellInit = "ZSH_TMUX_AUTOSTART=true";
      ohMyZsh = {
        enable = true;
        theme = "agnoster";
        plugins = [ "git" "tmux" ];
      };
    };
  };
  
  environment.systemPackages = with pkgs; [
    zsh tmux mc 
    unzip ntfs3g xarchiver
    gnupg gnupg1compat
    git cmake gnumake gcc
    firefox vlc screenfetch wget
    djview xpdf rsync ffmpeg-full
    python3 python36Packages.virtualenv python36Packages.pip
    chromium pavucontrol
  ];

  # Select internationalisation properties.
  i18n = {
    consoleFont = "UniCyr_8x16";
    consoleKeyMap = "ruwin_cplk-UTF-8";
    defaultLocale = "ru_RU.UTF-8";
    consoleColors = [ "000000" "dc322f" "859900" "b58900" "268bd2" "d33682"
                      "2aa198" "eee8d5" "002b36" "cb4b16" "586e75" "657b83"
                      "839496" "6c71c4" "93a1a1" "fdf6e3" ];
  };

  #Fonts
  fonts = {
    fonts = with pkgs; [
      noto-fonts
      noto-fonts-emoji
      noto-fonts-extra
      noto-fonts-cjk
    ];

    enableDefaultFonts = true;

    fontconfig.defaultFonts = {
      monospace = [ "Noto Mono" ];
      sansSerif = [ "Noto Sans" ];
      serif = [ "Noto Serif" ];
    };
  };
  
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

  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
    extraConfig = ''
      load-module module-switch-on-connect
    '';
  };

  services = {
    xserver = {
      enable = true;
      xkbModel = "microsoft";
      xkbVariant = "winkeys";
      layout = "us,ru(winkeys)";
      xkbOptions = "grp:caps_toggle";
      videoDrivers = [ "intel" ];
      libinput.enable = true;
      desktopManager = {
        enlightenment.enable = true;
        default = "Enlightenment";
      };
      displayManager.auto = { enable = true; user = "obliq"; };
    };

    compton = {
      enable = true;
      vSync = "opengl";
      shadow = true;
      menuOpacity = "0.9";
      shadowOpacity = "0.3";
    };

    acpid.enable = true;
    tlp.enable = true;
    illum.enable = true;
    printing.enable = true; # CUPS
    openssh.enable = true;
    dbus.enable = true;
    nixosManual.showManual = true;
    locate.enable = true;
    udisks2.enable = true;
    ntp.enable = true;
  };
  
  time.timeZone = "Europe/Moscow";
  
  system = {
    stateVersion = "18.09";
    autoUpgrade = {
      enable = true;
  };
}
