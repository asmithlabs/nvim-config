-- ~/.config/nvim/lua/plugins/treesitter.lua
return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = function()
      -- Clean up any stale tmp directory before updating
      local tmp = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/_tmp"
      if vim.fn.isdirectory(tmp) == 1 then
        vim.fn.delete(tmp, "rf")
      end
      vim.cmd("TSUpdate")
    end,
    config = function()
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

      parser_config.embedded_template = {
        install_info = {
          url = "https://github.com/tree-sitter/tree-sitter-embedded-template",
          files = { "src/parser.c" },
          requires_generate_from_grammar = true,
        },
        filetype = "eruby",    -- or "html.erb" if your filetype plugin sets that
        used_by = { "eruby" }, -- ensure it kicks in for .erb buffers
      }
      require("nvim-treesitter.configs").setup {
        ensure_installed = {
          -- Rails web development
          "ruby",         -- core Ruby language
          "embedded_template",
          "javascript",   -- front-end scripts
          "typescript",   -- typed JS
          "html",         -- markup
          "css",          -- stylesheets

          -- Python for ML / LLM
          "python",       -- core Python
          "json",         -- data interchange
          "yaml",         -- configuration
          "markdown",     -- docs / notebooks

          -- General-purpose tooling
          "bash",         -- shell scripts
          "dockerfile",   -- container definitions
          "sql",          -- database queries
          "lua",          -- Neovim configs & plugins
          "vim",          -- Vimscript files

          -- Optional / extras
          "graphql",      -- GraphQL queries
          "make",         -- Makefiles
        },
        sync_install = false,   -- don’t block Neovim startup
        auto_install = true,    -- install missing parsers on buffer enter
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      }
    end
  }
}

