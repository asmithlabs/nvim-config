return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    local diagnostics = null_ls.builtins.diagnostics
    local formatting = null_ls.builtins.formatting
    local completion = null_ls.builtins.completion

    local sources = {
      formatting.stylua,
      completion.spell,
      diagnostics.rubocop,
      formatting.rubocop,
      formatting.prettier,
    }

    -- Only add eslint_d if it's defined
    local ok, eslint_d = pcall(function()
      return diagnostics.eslint_d
    end)

    if ok and eslint_d then
      table.insert(sources, eslint_d.with({ only_local = "node_modules/.bin" }))
    end

    null_ls.setup({ sources = sources })

    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}

