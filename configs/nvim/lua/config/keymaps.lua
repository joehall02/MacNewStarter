-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- ESLint: fix all fixable problems in the current file
vim.keymap.set("n", "<leader>ci", function()
  vim.lsp.buf.code_action({
    apply = true,
    context = {
      ---@diagnostic disable-next-line: assign-type-mismatch
      only = { "source.fixAll.eslint" },
      diagnostics = {},
    },
  })
end, { desc = "ESLint Fix All (file)" })
