return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        -- Applies the fixes for the statix lints the nix extra shows,
        -- used by <leader>ci in nix files (see config/keymaps.lua)
        statix = {
          command = "statix",
          args = { "fix", "--stdin" },
          stdin = true,
        },
      },
    },
  },
}
