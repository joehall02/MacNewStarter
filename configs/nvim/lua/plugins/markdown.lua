return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = false,
  },
  {
    "iamcco/markdown-preview.nvim",
    init = function()
      vim.g.mkdp_theme = "dark"
    end,
  },
}
