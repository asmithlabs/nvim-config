return {
  -- Mason: installs LSP servers
  {
    "mason-org/mason.nvim",
    opts = {},
  },

  -- Mason-LSPConfig bridge
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
          "ts_ls", -- confirmed
          "pyright",
          "html",
          "emmet_language_server",
          "solargraph",
        },
        handlers = {
          function(server_name)
            if server_name ~= "lua_ls" then
              require("lspconfig")[server_name].setup({})
            end
          end,
        },
      })
    end,
  },

  -- LSPConfig: manual lua_ls + global keymaps + Emmet + Solargraph
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")
      local util = require("lspconfig.util")

      -- Lua LSP (manual setup)
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        single_file_support = false,
        root_dir = function(fname)
          local root = util.root_pattern(".luarc.json", ".luarc.jsonc", ".git")(fname)
          if not root or root == vim.loop.os_homedir() then return nil end
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

      -- Emmet
      lspconfig.emmet_language_server.setup({
        capabilities = capabilities,
        filetypes = {
          "html", "css", "scss", "sass", "less",
          "javascript", "javascriptreact", "typescriptreact",
          "eruby", "vue", "pug",
        },
        init_options = {
          showExpandedAbbreviation = "always",
          showAbbreviationSuggestions = true,
          showSuggestionsAsSnippets = false,
        },
      })

      -- Solargraph
      lspconfig.solargraph.setup({
        capabilities = capabilities,
        settings = {
          solargraph = {
            diagnostics = true,
            autoformat = true,
            formatting = true,
          },
        },
      })

      -- Global LSP keymaps
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
}

