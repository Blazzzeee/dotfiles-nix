return {
    "ThePrimeagen/harpoon",
    lazy = true,
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        { "<leader>a", function() require("harpoon.mark").add_file() end, desc = "Add file to harpoon" },
        { "<S-o>",     function() require("harpoon.ui").toggle_quick_menu() end, desc = "Toggle Harpoon menu" },
        { "<S-h>",     function() require("harpoon.ui").nav_file(1) end, desc = "Harpoon file 1" },
        { "<S-j>",     function() require("harpoon.ui").nav_file(2) end, desc = "Harpoon file 2" },
        { "<S-k>",     function() require("harpoon.ui").nav_file(3) end, desc = "Harpoon file 3" },
        { "<S-l>",     function() require("harpoon.ui").nav_file(4) end, desc = "Harpoon file 4" },
    },
    config = function()
        require("harpoon").setup({
            global_settings = {
                save_on_toggle = false,
                save_on_change = true,
                enter_on_sendcmd = false,
                tmux_autoclose_windows = false,
                excluded_filetypes = { "harpoon" },
            },
        })
    end,
}
