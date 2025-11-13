-- gitlinker.nvim - Generate shareable links to Gerrit
return {
  "ruifm/gitlinker.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("gitlinker").setup({
      opts = {
        remote = nil, -- force the use of a specific remote
        add_current_line_on_normal_mode = true,
        action_callback = require("gitlinker.actions").copy_to_clipboard,
        print_url = true,
      },
      callbacks = {
        ["artinfo-gerrit.volvocars.biz"] = function(url_data)
          -- Clean up repo name (remove leading 'a/' if present)
          local repo = url_data.repo:gsub("^a/", "")

          -- Use master as default branch
          local branch = "master"

          local url = "https://artinfo-gerrit.volvocars.biz"
          url = url .. "/plugins/gitiles/" .. repo
          url = url .. "/+/refs/heads/" .. branch
          url = url .. "/" .. url_data.file
          if url_data.lstart then
            if url_data.lend and url_data.lend ~= url_data.lstart then
              url = url .. "#" .. url_data.lstart .. "-" .. url_data.lend
            else
              url = url .. "#" .. url_data.lstart
            end
          end
          return url
        end,
      },
      mappings = "<leader>gy",
    })
  end,
  keys = {
    { "<leader>gy", mode = { "n", "v" }, desc = "Copy Gerrit link" },
    { "<leader>gY", mode = { "n", "v" }, desc = "Open Gerrit link in browser" },
  },
}
