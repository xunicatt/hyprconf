return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  config = function ()
    local comment = require("Comment")
    local ts_context_cs = require(
      "ts_context_commentstring.integrations.comment_nvim"
    )

    comment.setup({
      pre_hook = ts_context_cs.create_pre_hook(),
    })
  end
}
