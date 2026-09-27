-- lua/plugins/snacks-picker.lua
return {
  "folke/snacks.nvim",
  keys = {
    {
      "<leader><leader>",
      function()
        Snacks.picker.files({ hidden = true, ignored = true })
      end,
      desc = "Find Files (hidden + ignored)",
    },
    {
      "<leader>ff",
      function()
        Snacks.picker.files({ hidden = true, ignored = true })
      end,
      desc = "Find Files (hidden + ignored)",
    },
  },
}
