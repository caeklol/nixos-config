{ ... }:
{
   programs.zsh = {
       enable = true;
       initExtra = ''
	      bindkey "^[[1;5C" forward-word
	      bindkey "^[[1;5D" backward-word
	      bindkey "^[[1;6C" vi-forward-word
	      bindkey "^[[1;6D" vi-backward-word
      '';

      shellAliases = {
        garbage = "nix-collect-garbage -d";
        ut = "cd ~/utils";
        conf = "cd ~/.config/home-manager";
      };
   };
}
