return {
  {
    "folke/tokyonight.nvim",
    opts = {
      on_highlights = function(hl, c)
        hl.DiagnosticUnnecessary = { fg = "#e06c75", italic = true }
      end,
    },
  },
}
