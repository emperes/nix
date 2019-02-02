{ pkgs, ... }:
{
   zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      syntaxHighlighting.highlighters = [ "main" "brackets" "pattern" "cursor" "root" "line" ];
      interactiveShellInit = ''ZSH_TMUX_AUTOSTART=true
                               ZSH_TMUX_AUTOQUIT=true
                               ENABLE_CORRECTION="true"'';
      ohMyZsh = {
        enable = true;
        theme = "ys";
        plugins = [ "git" "tmux" "sudo" "systemd" "jira"
                    "httpie" "rsync" "git-extras"
                    "common-aliases" pip python vscode ]; }; };
                    
   environment.shellAliases = {
    ns = "nix-shell --command zsh";
    "XD" = ''echo "emperes"'';
    nixi = ''nix repl "<nixpkgs>"''; };
}
