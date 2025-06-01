return {
  "rmagatti/auto-session",
  config = function()
    local session = require("auto-session")
    session.setup({
      auto_restore_enable = false,
      auto_session_suppress_dirs = {},
    })

    local keymap = vim.keymap

    keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>")
    keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>")
  end
}
