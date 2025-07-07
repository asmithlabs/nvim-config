-- Fill characters (hide ~ at end of buffer)
vim.opt.fillchars:append({ eob = " " })

-- Editor settings
vim.opt.termguicolors = true
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.splitright = true
vim.opt.autowrite = true

-- Leader key and keymaps
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>mu", ":MasonUpdate<CR>", { desc = "Update Mason LSPs" })

-- Auto check SCSS files
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.scss",
  command = "checktime",
})

-- Load plugins
require("config.lazy")
