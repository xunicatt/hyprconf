return {
  "folke/todo-comments.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local todo = require("todo-comments")
    local keymap = vim.keymap

    keymap.set("n", "<leader>Tn", function()
      todo.jump_next()
    end)

    keymap.set("n", "<leader>Tp", function()
      todo.jump_prev()
    end)

    todo.setup()
  end
}
