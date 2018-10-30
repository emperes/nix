{
  i18n = {
    consoleFont = "UniCyr_8x16";
    consoleKeyMap = "ruwin_cplk-UTF-8";
    defaultLocale = "ru_RU.UTF-8";
    consoleColors = [ "161616" "a65353" "909653" "bd9c5a" "5f788c" "816b87" "688c88" "c5c5c5"
                      "4a4a4a" "cc6666" "b5bd68" "f0c674" "81a2be" "b294bb" "8abeb7" "f7f7f7" ];
  };
  fonts = {
    fonts = with pkgs; [ noto-fonts noto-fonts-emoji noto-fonts-extra noto-fonts-cjk ];
    enableDefaultFonts = true;
    fontconfig.defaultFonts = {
      monospace = [ "Noto Mono" ];
      sansSerif = [ "Noto Sans" ];
      serif = [ "Noto Serif" ];
    };
  };
}
