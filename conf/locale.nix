{ config, pkgs, ... }:
{
   time.timeZone = "Europe/Moscow";
   services.xserver.layout = "us,ru";
   services.xserver.xkbOptions = "grp:caps_toggle,grp_led:scroll"; # scroll,num,caps
}
