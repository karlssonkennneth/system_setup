-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- For conciseness
local opts = { noremap = true, silent = true }

-- Navigate between buffers with Tab
vim.keymap.set("n", "<Tab>", ":bnext<CR>", opts)
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", opts)

-- Set my > and < keys on Swedish keyboard to indentation
vim.keymap.set("n", "§", ">>", { noremap = true, silent = true })
vim.keymap.set("n", "°", "<<", { noremap = true, silent = true })

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
