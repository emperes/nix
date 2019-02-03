{ pkgs, ... }:
{
   programs = {
     bash = { enableCompletion = true; };
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
                     "httpie" "rsync" "git-extras" "vscode"
                     "common-aliases" "pip" "python" ]; }; }; };
                    
    environment.shellAliases = {
     qwe = "nix-env";
     "XD" = ''echo "emperes"'';
     nixi = ''nix repl "<nixpkgs>"''; };
}
