{ config, pkgs, ... }:
{
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
  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false;
  security.sudo.extraConfig = ''
    ALL ALL = (root) NOPASSWD: ${pkgs.systemd}/bin/shutdown
    ALL ALL = (root) NOPASSWD: ${pkgs.systemd}/bin/reboot '';
}
