return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    "nvim-tree/nvim-web-devicons",
  },
  config = function ()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = { "smart" },
      },
    })

    telescope.load_extension("fzf")

    local keymap = vim.keymap

    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
    keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<CR>")
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<CR>")
    keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<CR>")
  end
}
