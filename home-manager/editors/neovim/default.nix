{
  config,
  lib,
  pkgs,
  ...
}: let
  neovim = config.modules.editors.neovim;
in {
  options.modules.editors.neovim = {
    enable = lib.mkEnableOption "enable neovim";
  };

  config = lib.mkIf neovim.enable {
    home.packages = with pkgs; [
		vscode-langservers-extracted
    ];

    programs.neovim = {
      enable = true;
      extraLuaConfig = ''
           vim.opt.tabstop = 4
           vim.opt.shiftwidth = 4
           vim.opt.expandtab = false
           vim.g.mapleader = "\\"
      '';

      extraConfig = ''
        nnoremap Q "_
        command Sw normal :SudaWrite

        au BufEnter * set noro
        set relativenumber
      '';

      plugins = with pkgs.vimPlugins; [
        vim-suda
        {
          plugin = presence-nvim;
          type = "lua";
          config = ''
            require("presence").setup({
                auto_update         = true,
                neovim_image_text   = "Sorry",
                main_image          = "neovim",
                log_level           = nil,
                debounce_timeout    = 10,
                enable_line_number  = false,
                blacklist           = {},
                buttons             = true,
                file_assets         = {},
                show_time           = true,

                editing_text        = "Editing %s",
                file_explorer_text  = "Browsing %s",
                git_commit_text     = "Committing changes",
                plugin_manager_text = "Managing plugins",
                reading_text        = "Reading %s",
                workspace_text      = "Working on %s",
                line_number_text    = "Line %s out of %s",
            })
          '';
        }

        {
          plugin = telescope-fzf-native-nvim;
          type = "lua";
          config = ''
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader><leader>', builtin.find_files, {})
          '';
        }

        {
          plugin = catppuccin-nvim;
          type = "lua";
          config = ''
            vim.cmd.colorscheme "catppuccin"
          '';
        }

		{
          plugin = nvim-lspconfig;
          type = "lua";
          config = ''
		  	local lspconfig = require("lspconfig");
			lspconfig.eslint.setup({
				on_attach = function(client, bufnr)
				vim.api.nvim_create_autocmd("BufWritePre", {
				  buffer = bufnr,
				  command = "EslintFixAll",
				})
			  end,
			})

			lspconfig.rust_analyzer.setup({})
          '';
        }
      ];
    };

    home.sessionVariables.EDITOR = lib.mkForce "nvim"; # neovim has higher priority because
  };
}
