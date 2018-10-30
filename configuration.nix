{ config, pkgs, ... }:
{
  imports =
    [ ./hardware-configuration.nix
      ./boot.nix
      ./hardware.nix
      ./i18n.nix
      ./networking.nix
      ./programs.nix
      ./services.nix
      ./user.nix
    ];
}
