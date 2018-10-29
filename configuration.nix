# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only
  #hardware.opengl.enable = true;
  #hardware.opengl.driSupport = true;
  


  networking.hostName = "ollerus"; # Define your hostname.
  networking.networkmanager.enable = true;
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  
  # Enable unfree packages.
  nixpkgs.config.allowUnfree = true;
  
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
 
  programs = {
    #gnupg.agent = {
    #  enable = true;
    #  enableSshSupport = true;
    #};
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      interactiveShellInit = "ZSH_TMUX_AUTOSTART=true";
      ohMyZsh = {
        enable = true;
        theme = "gentoo";
        plugins = [ "git" "tmux" ];
      };
    };
  };
  
  environment.systemPackages = with pkgs; [
    zsh tmux mc 
    unzip ntfs3g xarchiver
    gnupg gnupg1compat
    git cmake gnumake gcc
    firefox vlc screenfetch
    linuxPackages.acpi_call wget
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

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  #services.openssh.enable = true;
  
  #Users
  users.extraUsers.obliq = {
    isNormalUser = true;
    name = "obliq";
    group = "users";
    uid = 1000;
    shell = pkgs.zsh;
    extraGroups = [
      "dialout" "plugdev" "audio" 
      "video" "disk" 
      "networkmanager" "systemd-journal" 
      "wheel"
    ];
    createHome = true;
    home = "/home/obliq";
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  #hardware.pulseaudio.enable = true;
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
    extraConfig = ''
      load-module module-switch-on-connect
    '';
  };


  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.xkbModel = "microsoft";
  services.xserver.xkbVariant = "winkeys";
  services.xserver.layout = "us,ru(winkeys)";
  services.xserver.xkbOptions = "grp:caps_toggle";
  services.xserver.videoDrivers = [ "intel" ];
  
  # Enable touchpad support.
  services.xserver.libinput.enable = true;

  # Enable Desktop Environment.
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.desktopManager.default = "xfce";

  services.xserver.displayManager.auto.enable = true;
  services.xserver.displayManager.auto.user = "obliq";

  services.acpid.enable = true;
  services.tlp.enable = true;

  system.stateVersion = "18.09"; # Did you read the comment?
  system.autoUpgrade.enable = true;

}
