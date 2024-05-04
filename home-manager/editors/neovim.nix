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
                 set number
        let g:coc_node_path = '${lib.getExe pkgs.nodejs_22}'
      '';

      plugins = with pkgs.vimPlugins; [
        suda-vim
        coc-nvim
        coc-eslint
        coc-rust-analyzer
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
          plugin = feline-nvim;
          type = "lua";
          config = ''
            local ctp_feline = require('catppuccin.groups.integrations.feline')

            require("feline").setup({
                components = ctp_feline.get(),
            })
          '';
        }

        {
          plugin = nvim-tree-lua;
          type = "lua";
          config = ''
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1

            -- optionally enable 24-bit colour
            vim.opt.termguicolors = true

            -- empty setup using defaults
            require("nvim-tree").setup()

            local api = require "nvim-tree.api"
            vim.keymap.set('n', '<leader>t', function() api.tree.open({ path = "<args>" }) end, {})
          '';
        }
      ];
    };

    home.sessionVariables = {
      EDITOR = "nvim";
    };
  };
}
