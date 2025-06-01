return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre",  "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    {
      "antosha417/nvim-lsp-file-operations",
      config = true,
    },
    {
      "folke/neodev.nvim",
      opts = {}
    }
  },
  config = function()
    local config = require("lspconfig")
    local mason_config = require("mason-lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local keymap = vim.keymap

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }
        keymap.set("n", "gd", vim.lsp.buf.declaration, opts)
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)
        keymap.set("n", "gD", "<cmd>Telescope lsp_definitions<CR>", opts)
        keymap.set("n", "gI", "<cmd>Telescope lsp_implementations<CR>", opts)
        keymap.set("n", "gT", "<cmd>Telescope lsp_type_definitions<CR>", opts)

        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
        keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, opts)
        keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, opts)
        keymap.set("n", "K", vim.lsp.buf.hover, opts)
      end
    })

    local capabilities = cmp_nvim_lsp.default_capabilities()
    mason_config.setup({
      function(server_name)
        config[server_name].setup({
          capabilities = capabilities,
        })
      end
    })
  end
}
