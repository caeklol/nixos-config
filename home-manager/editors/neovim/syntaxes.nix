
{ pkgs, ... }:
{
	programs.neovim = {
		plugins = with pkgs.vimPlugins; [
			vim-markdown
			vim-go
			vim-jsx-typescript
			rust-vim
			vim-nix
		];
	};
}
