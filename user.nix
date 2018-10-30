{
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
