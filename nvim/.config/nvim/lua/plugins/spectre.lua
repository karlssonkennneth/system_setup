-- nvim-spectre: Interactive search and replace (like VSCode)
return {
  "nvim-pack/nvim-spectre",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    {
      "<leader>sr",
      function()
        require("spectre").open()
      end,
      desc = "Replace in files (Spectre)",
    },
    {
      "<leader>sR",
      function()
        require("spectre").open_visual({ select_word = true })
      end,
      desc = "Replace current word",
    },
    {
      "<leader>sf",
      function()
        require("spectre").open_file_search()
      end,
      desc = "Replace in current file",
    },
  },
  opts = {
    open_cmd = "noswapfile vnew",
  },
}
