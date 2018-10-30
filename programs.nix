{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;
  programs.rootston.enable = true;
  programs.sway.enable = true;
  programs = {
    #gnupg.agent = {
    #  enable = true;
    #  enableSshSupport = true;
    #};
    #mtr.enable = true;
    java.enable = true;
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      interactiveShellInit = "ZSH_TMUX_AUTOSTART=true";
      ohMyZsh = {
        enable = true;
        theme = "agnoster";
        plugins = [ "git" "tmux" ];
      };
    };
  };
}
