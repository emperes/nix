{ config, pkgs, ... }:
{
  services = {
    acpid.enable = true;
    thermald.enable = true;
    tlp.enable = false;
    illum.enable = false;
    services.openssh.enable = true;
    dbus = { enable = true; packages = with pkgs; [ gnome2.GConf ]; };
    cron.enable = true;
    locate.enable = true;
    autorandr.enable = true;
    udisks2.enable = true;
    ntp.enable = true;
    tor.enable = true; };
    
  systemd = {
    services = {
      systemd-tmpfiles-setup.before = [ " sysinit.target " ];
      systemd-update-utmp.after = [ " systemd-tmpfiles-setup.service " ]; }; };
}
