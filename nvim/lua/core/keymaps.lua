vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>nh", ":nohl<CR>")

keymap.set("n", "<leader>sv", "<C-w>v")
keymap.set("n", "<leader>sh", "<C-w>s")
keymap.set("n", "<leader>se", "<C-w>=")
keymap.set("n", "<leader>sx", "<cmd>close<CR>")

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>")
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>")
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>")
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>")

-- Scroll
keymap.set("n", "<leader>u", "<C-u>", { noremap = true, silent = true })
keymap.set("n", "<leader>d", "<C-d>", { noremap = true, silent = true })

-- create a new terminal
keymap.set("n", "<leader>tl", function()
  vim.cmd("vsplit | terminal")
  vim.cmd("startinsert")
end)
-- go to normal mode in terminal
keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true })
-- switch back to terminal
keymap.set("n", "<leader>ts", function()
  -- You can use wincmd h/l/j/k depending on split layout
  vim.cmd("wincmd l")  -- go left
  vim.cmd("startinsert")
end, { desc = "Focus terminal and enter insert mode" })

