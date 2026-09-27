return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        position = "right",
      },
      filesystem = {
        filtered_items = {
          visible = true, -- show hidden/filtered items by default
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
    },
  },
}
