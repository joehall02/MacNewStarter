return {
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "night",
      -- Let the terminal background show through instead of painting our own
      transparent = true,
      styles = {
        sidebars = "transparent", -- neo-tree, help
        floats = "transparent", -- lsp hover, which-key, pickers
      },
    },
  },
  { "LazyVim/LazyVim", opts = { colorscheme = "tokyonight" } },
}
