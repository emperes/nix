{ config, pkgs, ... }:
{
  virtualisation = { 
    docker.enable = true;
    virtualbox.host.enable = true;
    virtualbox.guest.enable = true:
    libvirtd.enable = true; };
}
