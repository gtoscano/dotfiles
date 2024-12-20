vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.backspace = '2'
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.cursorline = true
vim.opt.autoread = true

-- use spaces for tabs and whatnot
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.shiftround = true
vim.opt.expandtab = true

vim.cmd [[ set noswapfile ]]

--Line numbers
vim.wo.number = true

vim.o.clipboard = 'unnamedplus'
vim.o.mouse = 'a'
vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.hlsearch = true
vim.o.incsearch = true




vim.opt.undofile = true
-- vim.opt.undodir = "/home/gtoscano/.config/nvim/undodir"

vim.opt.undodir = vim.fn.stdpath('config') .. "/undodir"

