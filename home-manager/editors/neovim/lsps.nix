# https://github.com/Misterio77/nix-config/blob/main/home/gabriel/features/nvim/lsp.nix
{pkgs, ...}: {
  home.packages = with pkgs; [
    nodePackages.bash-language-server
    gopls
    nodePackages.typescript-language-server
    rust-analyzer
    nixd
  ];

  programs.neovim.plugins = with pkgs.vimPlugins; [
    otter-nvim

    {
      plugin = nvim-lspconfig;
      type = "lua";
      config = ''
        local lspconfig = require('lspconfig')
        function add_lsp(server, options)
              	    if not options["cmd"] then
              	      options["cmd"] = server["document_config"]["default_config"]["cmd"]
              	    end
              	    if not options["capabilities"] then
              	      options["capabilities"] = require("cmp_nvim_lsp").default_capabilities()
              	    end

              	    if vim.fn.executable(options["cmd"][1]) == 1 then
                      server.setup(options)
              	    end
              	  end

              	  add_lsp(lspconfig.bashls, {})
              	  add_lsp(lspconfig.gopls, {})
                  add_lsp(lspconfig.tsserver, {})
                  add_lsp(lspconfig.rust_analyzer, {})

              	  add_lsp(lspconfig.nixd, { settings = { nixd = {
              	    formatting = { command = { "alejandra" }}
              	  }}})
      '';
    }
    {
      plugin = rust-tools-nvim;
      type = "lua";
      config = ''
         local rust_tools = require('rust-tools')
         add_lsp(rust_tools, {
        cmd = { "rust-analyzer" },
        tools = { autoSetHints = true }
         })
         vim.api.nvim_set_hl(0, '@lsp.type.comment.rust', {})
      '';
    }

    luasnip
    cmp-nvim-lsp
    cmp_luasnip
    lspkind-nvim

    {
      plugin = nvim-cmp;
      type = "lua";
      config = ''
         local cmp = require('cmp')

         cmp.setup({
        formatting = {
          format = require('lspkind').cmp_format({
        	before = function (entry, vim_item)
        	  return vim_item
        	end,
          }),
        },
        snippet = {
          expand = function(args)
        	require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
        }),
        sources = {
          { name='otter' },
          { name='nvim_lsp' },
          { name='luasnip' },
        },
         })
      '';
    }
  ];
}
