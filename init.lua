vim.opt.fillchars = vim.opt.fillchars or {}    -- ensure table
vim.opt.fillchars:append { eob = " " }	
-- vim commands  
vim.opt.termguicolors= true
vim.cmd("set expandtab")
vim.cmd("set number")
vim.cmd("set relativenumber")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
-- map leader 
vim.g.mapleaer = ' ' 

require("config.lazy")
  
