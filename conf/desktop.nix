{ config, pkgs, ... }:
{
  services = {
    compton = { enable = true; vSync = "opengl"; };
    xserver = {
      enable = true;
      displayManager.auto = { enable = true; user = "obliq"; };
      desktopManager = { xfce.enable = true; default = "xfce"; }; }; };
}
