return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "DaikyXendo/nvim-material-icon",
  config = function()
    local tree = require("nvim-tree")
    local api = require("nvim-tree.api")

    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    local git_ignored = false

    local function setup()
      tree.setup({
        view = {
          width = 35,
          relativenumber = true,
        },
        actions = {
          open_file = {
            window_picker = { enable = false },
          },
        },
       filters = {
          dotfiles = false,
          git_ignored = git_ignored,
        },
      })
    end

    local function toggle_git_ignored()
      git_ignored = not git_ignored
      setup()
      api.tree.reload()
      api.tree.open()
    end

    setup()


    local keymap = vim.keymap

    keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>")
    keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>")
    keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>")
    keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>")
    keymap.set("n", "<leader>gi", toggle_git_ignored)
  end
}
