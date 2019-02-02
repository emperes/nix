{ config, pkgs, ... }:
{ imports = [ ./hardware-configuration.nix ];
  boot = {
    cleanTmpDir = true;
    kernelModules = [ "kvm-intel" "fuse" "crc32c-intel" ];
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = [ "ntfs-3g" ];
    loader = {
      #systemd-boot.enable = true;
      #efi.efiSysMountPoint = "/boot/efi";
      grub = {
        #efiSupport = true;
        #efiInstallAsRemovable = true;
        #useOSProber = true;
        enable = true;
        version = 2;
        device = "/dev/sda"; }; }; };
  environment.systemPackages = with pkgs; ([
    tmux mc ntfs3g python2Full mate.engrampa
    gnupg gnupg1compat gitFull cmake gnumake gcc8 
    firefox vlc neofetch wget python3Full iw cabal-install
    djview xpdf rsync ffmpeg-full python37Full
    chromium pavucontrol geany aqemu pinentry cachix
    ripgrep global coreutils skype adobe-reader
    direnv emacs fasd fzf zip unzip unrar p7zip
    fuse appimage-run libreoffice-fresh vscode nim
    bison flex openssl curl apulse pamixer pamix
    snappy libopus nss xorg.libxkbfile xorg.libXScrnSaver
    harfbuzzFull gtk2-x11 gnome2.gtk flac libelf
    xdg_utils gparted acpi bc acpitool htop ncurses
    imagemagick speedcrunch links paprefs pasystray tor 
    torsocks torbrowser playonlinux wineFull winetricks
    audacity gnome3.gnome-sound-recorder wxcam acpid
    xfce.xfce4-xkb-plugin xfce.xfce4-clipman-plugin
    xmonad-with-packages
    #virtualboxWithExtpack linuxPackages.virtualboxGuestAdditions
    #linuxPackages.virtualbox
    ] ++
    ( with haskellPackages; [
      ghcid
      xmobar
      yeganesh
      DescriptiveKeys
      xmonad
      xmonad-contrib
      xmonad-entryhelper
      xmonad-extras
      xmonad-screenshot
      xmonad-utils
      xmonad-volume
    ])
  ++ lib.optionals stdenv.isLinux [
    arandr autorandr cabal2nix
    docker docker_compose dunst feh
    libnotify lightum powertop rofi rofi-menugen
    rofi-pass scrot rofi-systemd
    stalonetray unclutter-xfixes
    wirelesstools xclip xsel
    xorg.libXrandr xorg.xbacklight
    xorg.xcursorthemes xorg.xf86inputkeyboard zeal
  ]);
  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [ 
      noto-fonts noto-fonts-emoji
      noto-fonts-extra noto-fonts-cjk
      liberation_ttf ];
    enableDefaultFonts = true;
    fontconfig.defaultFonts = {
      monospace = [ "Noto Mono" ];
      sansSerif = [ "Noto Sans" ];
      serif = [ "Noto Serif" ]; }; };
  sound = { enable = true; mediaKeys.enable = true; };
  zramSwap = { enable = true; memoryPercent = 50; };
  time.timeZone = "Europe/Moscow";
  #powerManagement.cpuFreqGovernor = "performance";
  hardware = {
    bluetooth.enable = true;
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = true;
    #cpu.amd.updateMicrocode = true;
    enableAllFirmware = true;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [ vaapiIntel libvdpau-va-gl vaapiVdpau ];
      extraPackages32 = with pkgs.pkgsi686Linux; [ vaapiIntel libvdpau-va-gl vaapiVdpau ];
      s3tcSupport = true; };
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
      support32Bit = true;
      systemWide = true; }; };
  i18n = {
    consoleFont = "UniCyr_8x16";
    consoleKeyMap = "ruwin_cplk-UTF-8";
    defaultLocale = "ru_RU.UTF-8";
    consoleColors = [ "1C1B19" "EF2F27" "519F50" "FBB829"
                      "2C78BF" "E02C6D" "0AAEB3" "918175"
                      "2D2C29" "F75341" "98BC37" "FED06E"
                      "68A8E4" "FF5C8F" "53FDE9" "FCE8C3" ]; };
  networking = { hostName = "ollerus"; networkmanager.enable = true; };
  programs = {
    java.enable = true;
    mtr.enable = true;
    adb.enable = true;
    light.enable = true;
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      interactiveShellInit = ''ZSH_TMUX_AUTOSTART=true
                               ZSH_TMUX_AUTOQUIT=true'';
      ohMyZsh = {
        enable = true;
        theme = "bira";
        plugins = [ "tmux" "sudo" "systemd" 
                    "jira" "httpie" "rsync"
                    "git-extras" "common-aliases" 
                    "pip" "python" "vscode" ]; }; }; };
  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false;
  security.sudo.extraConfig = ''
    ALL ALL = (root) NOPASSWD: ${pkgs.iw}/bin/iw
    ALL ALL = (root) NOPASSWD: ${pkgs.light}/bin/light
    ALL ALL = (root) NOPASSWD: ${pkgs.systemd}/bin/shutdown
    ALL ALL = (root) NOPASSWD: ${pkgs.systemd}/bin/reboot
  '';
  services.actkbd.enable = true;
  services.acpid.enable = true;
  services.thermald.enable = true;
  services.tlp.enable = true;
  services.illum.enable = true;
  services.printing = {
    enable = true;
    drivers = with pkgs; [ hplipWithPlugin epson-escpr gutenprint splix cups-bjnp
                           gutenprintBin samsungUnifiedLinuxDriver ghostscript ]; };
  services.openssh.enable = true;
  services.dbus = { enable = true; packages = with pkgs; [ gnome2.GConf ]; };
  services.cron.enable = true;
  services.locate.enable = true;
  services.autorandr.enable = true;
  services.udisks2.enable = true;
  services.ntp.enable = true;
  services.tor.enable = true;
  system = { 
    #autoUpgrade.enable = true;
    stateVersion = "unstable";
    autoUpgrade.channel = https://nixos.org/channels/nixos-unstable; };
  nix = {
    gc.automatic = true; 
    autoOptimiseStore = true; 
    useSandbox = true;
    binaryCaches = [ "https://cache.nixos.org/" "https://ollerus.cachix.org" ];
    binaryCachePublicKeys = [ "ollerus.cachix.org-1:5gHLNiV9Zk5rltV0+ITJGLUTrkGK0ls0ZdeCIPbviQo=" ];
    trustedUsers = [ "obliq" "root" ]; };
  nixpkgs.config = { 
    allowUnsupportedSystem = false; 
    allowBroken = true; 
    allowUnfree = true; };
  users.extraGroups.pulse-access.members = [ "nick" "other" "guest" "root" "users" "wheel" ];
  users.extraGroups.audio.members = [ "nick" "other" "guest" "root" "users" "wheel" ];
  users.extraUsers.obliq = {
    isNormalUser = true;
    group = "users";
    uid = 1000;
    shell = pkgs.zsh;
    extraGroups = [ "audio" "adb" "adbuser" "docker" "host"
                    "pulse" "video" "wheel" "vboxusers" "systemd-journal"
                    "libvirtd" "docker" "virtualisation" "networkmanager"
                    "disk" "messagebus" ]; };
  virtualisation = { 
    docker.enable = true; 
    virtualbox.host.enable = true; 
    libvirtd.enable = true; };
  systemd.services = {
    systemd-tmpfiles-setup.before = [ " sysinit.target " ];
    systemd-update-utmp.after = [ " systemd-tmpfiles-setup.service " ]; };
  services.xserver.enable = true;
  services.xserver.layout = "us,ru";
  services.xserver.xkbOptions = "grp:caps_toggle,grp_led:num"; # scroll,num,caps
  #services.xserver.libinput.enable = true;
  #services.xserver.windowManager = { default = "xmonad"; xmonad = { enable = true; enableContribAndExtras = true; }; };
  services.xserver.desktopManager = { 
    default = "xfce"; 
    xfce.enable = true;
    xfce.enableXfwm = true; };
  services.xserver.displayManager.auto = { enable = true; user = "obliq"; };
  services.xrdp.defaultWindowManager = "xmonad";
  services.xserver.videoDrivers = [ "intel" ];
  services.xserver.synaptics = { 
    enable = true;
    accelFactor = "0.0350939";
    vertEdgeScroll = false;
    horizEdgeScroll = false;
    additionalOptions = ''
	       Option "LTCornerButton" "2"
	       Option "RTCornerButton" "3"
	       Option "TapAndDragGesture" "1"
	       Option "CircularScrolling" "1"
	       Option "CircScrollTrigger" "3"
	       Option "CircScrollDelta" "0.100007"
  ''; };
  services.compton.enable = true;
  services.compton.vSync = "opengl"; }
