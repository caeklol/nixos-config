# https://github.com/Misterio77/nix-config/blob/main/home/gabriel/features/nvim/lsp.nix
{...}: {
  programs.neovim.extraLuaConfig = ''
    --    [[settings]]
          vim.opt.tabstop = 4
          vim.opt.shiftwidth = 4
          vim.opt.expandtab = false

          vim.opt.relativenumber = true

    --    [[keybinds]]
          vim.g.mapleader = "\\"

          -- from: primeagen
          vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
  '';
}
