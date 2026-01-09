--Execute lua file
vim.api.nvim_set_keymap("", "<Up>", "<Nop>", {})
    vim.keymap.del("n", "grr")
    vim.keymap.del("n", "gri")
    vim.keymap.del("n", "grn")
    vim.keymap.del("n", "gra")
vim.api.nvim_create_autocmd("FileType", {
	pattern = "lua",
	callback = function()
		-- map <leader>r in Lua buffers to :luafile %
		vim.keymap.set("n", "<leader>r", ":luafile %<CR>", { buffer = true, desc = "Run Lua file" })
	end,
})
--navigate files like a pro

vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })

--reszie panes
vim.keymap.set("n", "<A-Up>", ":resize +2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-Down>", ":resize -2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-Left>", ":vertical resize -2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-Right>", ":vertical resize +2<CR>", { noremap = true, silent = true })

--quickfix
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>", { desc = "Quickfix next item" })
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>", { desc = "Quickfix next item" })

-- Helix-style movement mappings
vim.keymap.set("n", "<leader>q", "<cmd>Neotree toggle<CR>", { desc = "Open file tree" })

vim.keymap.set({"n", "v", "o"}, "gh", "^", { desc = "Goto line start", noremap = true })
vim.keymap.set({"n", "v", "o"}, "gl", "$", { desc = "Goto line end", noremap = true })
vim.keymap.set({"n", "v", "o"}, "gg", "gg", { desc = "Goto file start", noremap = true })
vim.keymap.set({"n", "v", "o"}, "ge", "G", { desc = "Goto file end", noremap = true })
vim.keymap.set({"n", "v", "o"}, "gw", "w", { desc = "Next word", noremap = true })
vim.keymap.set({"n", "v", "o"}, "gx", "<nop>", { desc = "", noremap = true })

