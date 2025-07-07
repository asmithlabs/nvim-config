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

    -- From none-ls-extras
    local eslint_d = require("none-ls.diagnostics.eslint_d")

    local sources = {
      -- Formatting
      formatting.stylua,
      formatting.rubocop,
      formatting.prettier,

      -- Diagnostics
      diagnostics.rubocop,
      eslint_d.with({ only_local = "node_modules/.bin" }),

      -- Optional: spellcheck in comments
      completion.spell,
    }

    null_ls.setup({
      sources = sources,
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr, async = false })
            end,
          })
        end
      end,
    })

    vim.keymap.set("n", "<leader>gf", function()
      vim.lsp.buf.format({ async = true })
    end, { desc = "Format buffer" })
  end,
}

