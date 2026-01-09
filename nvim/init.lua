vim.opt.number = true
vim.opt.relativenumber = true
vim.g.mapleader = " "
vim.g.maplocalleader = " "
require("config.lazy")
vim.cmd("colorscheme vague")
require("keymap")
require("floaterm")
vim.opt.clipboard = "unnamedplus"

-- Navigate to previous dir
vim.keymap.set("n", "<space>pv", function()
    vim.cmd.Ex()
end)

--Set cursor style to block in insert mode

-- vim.opt.guicursor = "i:block"

-- Add paths for fd, find, and rg manually
vim.env.PATH = vim.env.PATH .. ':/home/blazzee/.nix-profile/bin:/run/current-system/sw/bin'

--annoying save prompt

vim.opt.shortmess:append("c")

--tab spacing

-- Use spaces instead of tabs
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 2
vim.o.smartindent = true
vim.opt.termguicolors = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.cursorline = true

--Disable arrow keys
vim.cmd("map <Up> <Nop>")
vim.cmd("map <Down> <Nop>")
vim.cmd("map <Left> <Nop>")
vim.cmd("map <Right> <Nop>")

--LSP previews

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        show_header = true,
        source = "always",
        border = "rounded",
        focusable = false,
    },
})
