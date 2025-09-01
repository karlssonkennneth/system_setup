return {
  "akinsho/toggleterm.nvim",
  keys = {
    { "<C-t>", "<cmd>ToggleTerm direction=float<cr>", mode = { "n", "i", "t" }, desc = "Toggle terminal" },
    { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Horizontal terminal" },
    { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Vertical terminal" },
  },
  opts = {
    size = 25, -- Number of lines the terminal should be
    open_mapping = [[<C-t>]], -- This makes Ctrl+T work in terminal mode too
    direction = "horizontal",
    float_opts = { border = "curved" },
  },
}
