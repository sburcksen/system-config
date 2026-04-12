-- Line number
vim.opt.nu = true
vim.opt.relativenumber = true

-- Indenting
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

-- Wrapping
vim.opt.wrap = false

-- Undo
vim.opt.swapfile = false
vim.opt.backup = false
--vim.opt.undodir = "$XDG_STATE_HOME/nvim/un"
vim.opt.undofile = true

-- Search highlighting
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Better colors
vim.opt.termguicolors = true

-- Scrolling
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- Time before backup is created
vim.opt.updatetime = 500

-- Vertical line
vim.opt.colorcolumn = "80"

-- Fat cursor
vim.opt.guicursor = ""
