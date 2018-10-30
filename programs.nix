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
}
