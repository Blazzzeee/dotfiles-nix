return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    -- event = "BufReadPost",  -- load on file open
    config = function()
      require("telescope").setup({
        defaults = {
          layout_strategy = "horizontal",
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = {
              preview_width = 0.4,
              prompt_position = "top",
              results_position = "top",
              results_width = 0.6,
            },
            width = 0.8,
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      require("telescope").load_extension("ui-select")

      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "search file" })
      vim.keymap.set("n", "<leader>e", builtin.git_files, { desc = "search files (git)" })
      vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "live grep" })
      vim.keymap.set("n", "<leader>h", builtin.help_tags, { desc = "help neovim" })
      vim.keymap.set("n", "<leader>s", builtin.lsp_document_symbols, { desc = "symbol picker (file)" })
      vim.keymap.set("n", "<leader>S", builtin.lsp_dynamic_workspace_symbols, { desc = "symbol picker (global)" })
      vim.keymap.set("n", "<leader>tm", builtin.man_pages, { desc = "Telescope browse man pages" })
      vim.keymap.set("n", "<leader>co", builtin.colorscheme, { desc = "Telescope change colorscheme" })
      vim.keymap.set("n", "<leader>tkb", builtin.keymaps, { desc = "Telescope show keymaps" })
    end,
  },

  -- Lazy-load telescope on keypress <leader>f or <leader>/
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    keys = {
      { "<leader>f", function() require("telescope.builtin").find_files() end, desc = "search file" },
      { "<leader>/", function() require("telescope.builtin").live_grep() end, desc = "live grep" },
    },
  },
}
