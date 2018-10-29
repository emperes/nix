{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  #boot.loader.efi.efiSysMountPoint = "/boot/efi";
  #boot.loader.grub.efiSupport = true;
  #boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages = with pkgs; [ vaapiIntel libvdpau-va-gl vaapiVdpau ];
  hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ vaapiIntel libvdpau-va-gl vaapiVdpau ];
  hardware.opengl.s3tcSupport = true;
  networking.hostName = "ollerus"; # Define your hostname.
  networking.networkmanager.enable = true;
  #networking.wireless.enable = true;  # wpa_supplicant
  #networking.firewall.allowedTCPPorts = [ ... ];
  #networking.firewall.allowedUDPPorts = [ ... ];
  #networking.firewall.enable = false;
  #networking.proxy.default = "http://user:password@proxy:port/";
  #networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  nixpkgs.config.allowUnfree = true;
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

  i18n = {
    consoleFont = "UniCyr_8x16";
    consoleKeyMap = "ruwin_cplk-UTF-8";
    defaultLocale = "ru_RU.UTF-8";
    consoleColors = [ "000000" "dc322f" "859900" "b58900" "268bd2" "d33682"
                      "2aa198" "eee8d5" "002b36" "cb4b16" "586e75" "657b83"
                      "839496" "6c71c4" "93a1a1" "fdf6e3" ];
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

  services.xserver.enable = true;
  services.xserver.xkbModel = "microsoft";
  services.xserver.xkbVariant = "winkeys";
  services.xserver.layout = "us,ru(winkeys)";
  services.xserver.xkbOptions = "grp:caps_toggle";
  services.xserver.videoDrivers = [ "intel" ];
  services.xserver.libinput.enable = true;
  services.xserver.desktopManager.enlightenment.enable = true;
  services.xserver.desktopManager.default = "Enlightenment";
  services.xserver.displayManager.auto = { enable = true; user = "obliq"; };
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
  services.nixosManual.showManual = true;
  services.locate.enable = true;
  services.udisks2.enable = true;
  services.ntp.enable = true;
  time.timeZone = "Europe/Moscow";
  system.autoUpgrade.enable = true;
  system.stateVersion = "18.09";
}
