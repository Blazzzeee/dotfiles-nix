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

vim.opt.guicursor = "i:block"

-- Add paths for fd, find, and rg manually
vim.env.PATH = vim.env.PATH .. ':/home/blazzee/.nix-profile/bin:/run/current-system/sw/bin'

--annoying save prompt

vim.opt.shortmess:append("c")

--tab spacing

-- Use spaces instead of tabs
vim.o.expandtab = true
vim.o.shiftwidth = 2
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

function Highlightscmp()
    local set = vim.api.nvim_set_hl

    -- Popup window + selection
    set(0, "PmenuSel", { link = "Visual" })        -- selection uses colorscheme Visual
    set(0, "Pmenu",    { link = "NormalFloat" })   -- menu bg/fg matches float windows

    -- Abbreviation (deprecated / match highlighting)
    set(0, "CmpItemAbbrDeprecated", { link = "Comment" })
    set(0, "CmpItemAbbrMatch",      { link = "Search" })
    set(0, "CmpItemAbbrMatchFuzzy", { link = "IncSearch" })

    -- Kinds → link to colorscheme groups
    local kinds = {
        Variable   = "Identifier",
        Interface  = "Type",
        Text       = "String",

        Function   = "Function",
        Method     = "Function",

        Keyword    = "Keyword",
        Property   = "Identifier",
        Unit       = "Number",
    }

    for kind, group in pairs(kinds) do
        set(0, "CmpItemKind" .. kind, { link = group })
    end
end

Highlightscmp()

--Breakpoints color
vim.fn.sign_define("DapBreakpoint", { text = "B", texthl = "DapBreakpoint", linehl = "", numhl = "" })
vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#ffffff", bg = "none" })

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

--White Line numbers
-- vim.cmd([[highlight LineNr guifg=#CDD6F4]])
-- vim.cmd([[highlight CursorLineNr guifg=#CDD6F4]])


-- vim.api.nvim_create_autocmd("BufReadPost", {
--     group = vim.api.nvim_create_augroup("LoadLualineRealBufferOnly", { clear = true }),
--     callback = function(args)
--         local ft = vim.bo[args.buf].filetype
--         local bt = vim.bo[args.buf].buftype
--         if bt == "" and ft ~= "netrw" and ft ~= "alpha" and ft ~= "lazy" then
--             require("lazy").load({ plugins = { "lualine.nvim" } })
--             vim.api.nvim_del_augroup_by_name("LoadLualineRealBufferOnly")
--         end
--     end,
-- })
