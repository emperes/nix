{
  nixpkgs.config = { allowBroken = true; allowUnfree = true; };
  programs = {
    #gnupg.agent = {
    #  enable = true;
    #  enableSshSupport = true;
    #};
    #mtr.enable = true;
    rootston.enable = true;
    sway.enable = true;
    java.enable = true;
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      interactiveShellInit = "ZSH_TMUX_AUTOSTART=true";
      ohMyZsh = {
        enable = true;
        theme = "bira";
        plugins = [ "git" "tmux" ];
      };
    };
  };
  environment.systemPackages = with pkgs; [ tmux mc unzip ntfs3g xarchiver
                                            gnupg gnupg1compat git cmake gnumake gcc 
                                            firefox vlc screenfetch wget
                                            djview xpdf rsync ffmpeg-full python37Full
                                            chromium pavucontrol pasystray paprefs ];
}
