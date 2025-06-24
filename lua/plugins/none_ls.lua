return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics
    local completion = null_ls.builtins.completion

    -- Explicitly load eslint_d from extras
    local eslint_d = require("none-ls.diagnostics.eslint_d")

    local sources = {
      formatting.stylua,
      completion.spell,
      diagnostics.rubocop,
      formatting.rubocop,
      formatting.prettier,
      eslint_d.with({ only_local = "node_modules/.bin" }),
    }

    null_ls.setup({ sources = sources })

    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}

