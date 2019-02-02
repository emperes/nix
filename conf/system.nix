{ config, pkgs, ... }:
{
  services = {
    acpid.enable = true;
    thermald.enable = true;
    tlp.enable = true;
    illum.enable = true;
    services.openssh.enable = true;
    dbus = { enable = true; packages = with pkgs; [ gnome2.GConf ]; };
    cron.enable = true;
    locate.enable = true;
    autorandr.enable = true;
    udisks2.enable = true;
    ntp.enable = true;
    tor.enable = true; };
}
