return {
  {
    "mason-org/mason.nvim",
    opts = {},
  },

  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "ts_ls",
          "pyright",
          "html",
          "cssls",
          "css_variables",
          "cssmodules_ls",
          "emmet_language_server",
          "solargraph",
          "ruby_lsp",
          "stimulus_ls",
        },
        handlers = {
          function(server_name)
            if server_name ~= "lua_ls" then
              require("lspconfig")[server_name].setup({
                capabilities = require("cmp_nvim_lsp").default_capabilities(
                  vim.lsp.protocol.make_client_capabilities()
                ),
              })
            end
          end,
        },
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      local lspconfig = require("lspconfig")
      local util = require("lspconfig.util")

      -- Lua LS
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        single_file_support = false,
        root_dir = function(fname)
          local root = util.root_pattern(".luarc.json", ".luarc.jsonc", ".git")(fname)
          if not root or root == vim.loop.os_homedir() then
            return nil
          end
          return root
        end,
        on_init = function(client)
          if client.config.root_dir == vim.loop.os_homedir() then
            print("✋ Blocked Lua LS in $HOME")
            client.stop()
          end
        end,
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
              path = { "lua/?.lua", "lua/?/init.lua" },
            },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
                vim.fn.stdpath("config") .. "/lua",
              },
            },
          },
        },
      })

      lspconfig.emmet_language_server.setup({
        capabilities = capabilities,
        filetypes = {
          "html",
          "css",
          "scss",
          "sass",
          "less",
          "javascript",
          "javascriptreact",
          "typescriptreact",
          "eruby",
          "vue",
          "pug",
        },
        init_options = {
          showExpandedAbbreviation = "always",
          showAbbreviationSuggestions = true,
          showSuggestionsAsSnippets = false,
        },
      })

      lspconfig.solargraph.setup({ capabilities = capabilities })
      lspconfig.ruby_lsp.setup({ capabilities = capabilities })
      lspconfig.ts_ls.setup({ capabilities = capabilities })
      lspconfig.html.setup({ capabilities = capabilities })
      lspconfig.cssls.setup({
        capabilities = capabilities,
        filetypes = { "css", "scss", "less" },
        init_options = { provideFormatter = true },
        settings = {
          css = { validate = true },
          less = { validate = true },
          scss = { validate = true },
        },
        root_dir = util.root_pattern("package.json", ".git"),
      })
      lspconfig.cssmodules_ls.setup({
        capabilities = capabilities,
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
        root_dir = util.root_pattern("package.json"),
        on_attach = custom_on_attach,
        -- optionally
        init_options = {
          camelCase = "dashes",
        },
      })
      lspconfig.css_variables.setup({
        capabilities = capabilities,
        filetypes = { "css", "scss", "less" },
        root_dir = util.root_pattern("package.json"),
      })
      lspconfig.stimulus_ls.setup({
        capabilities = capabilities,
        filetypes = { "javascript", "typescript" },
      })

      -- Keymaps
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
}
