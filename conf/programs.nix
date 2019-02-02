{ config, pkgs, ... }:
{
  programs = {
    java.enable = true;
    mtr.enable = true;
    adb.enable = true;
    light.enable = true; };
}    
