{ config, pkgs, ... }:
{
  networking = { hostName = "emperes"; networkmanager.enable = true; };
