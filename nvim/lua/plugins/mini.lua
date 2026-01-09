return {
    'https://github.com/nvim-mini/mini.pick',

    config = function ()

        local pick = require("mini.pick")

        pick.setup()

        vim.keymap.set("n", "<leader>f", "<cmd>Pick files<CR>", { desc = "search file" })
        vim.keymap.set("n", "<leader>/", "<cmd>Pick grep_live<CR>", { desc = "live grep" })
        vim.keymap.set("n", "<leader>h", "<cmd>Pick help_tags<CR>", { desc = "help neovim" })

    end,
}
