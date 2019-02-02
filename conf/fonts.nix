{ config, pkgs, ... }:
{
   fonts = {
    fonts = with pkgs; [ noto-fonts noto-fonts-emoji
                         noto-fonts-extra noto-fonts-cjk
                         liberation_ttf dejavu_fonts
                         emacs-all-the-icons-fonts
                         hasklig powerline-fonts
                         fira-code fira-code-symbols
                         iosevka emojione google-fonts
                         hack-font inconsolata monoid ];
                         
    enableDefaultFonts = true;
    enableGhostscriptFonts = true;
    
    fontconfig.defaultFonts = {
      monospace = [ "Noto Mono" ];
      sansSerif = [ "Noto Sans" ];
      serif = [ "Noto Serif" ]; }; };
}
