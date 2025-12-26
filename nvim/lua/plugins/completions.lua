return {
  {
    --Luasnip for expanding snippets
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "saadparwaiz1/cmp_luasnip",
    },
    init = function()
      -- Delay loading in non-filetype buffers like netrw, prompt, etc.
      vim.api.nvim_create_autocmd("InsertEnter", {
        group = vim.api.nvim_create_augroup("LazyLoadCmpRealBuffer", { clear = true }),
        callback = function()
          local bt = vim.api.nvim_get_option_value("buftype", { buf = 0 })
          local ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
          if bt == "" and ft ~= "netrw" then
            require("lazy").load({ plugins = { "nvim-cmp" } })
          end
        end,
      })
    end,
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      local ls = require("luasnip")

      vim.keymap.set({ "i" }, "<C-K>", function()
        ls.expand()
      end, { silent = true })
      vim.keymap.set({ "i", "s" }, "<C-L>", function()
        ls.jump(1)
      end, { silent = true })
      vim.keymap.set({ "i", "s" }, "<C-J>", function()
        ls.jump(-1)
      end, { silent = true })

      vim.keymap.set({ "i", "s" }, "<C-E>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end, { silent = true })
    end,
  },{
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      require("copilot_cmp").setup({
        method = "getCompletionsCycling", -- best UX
      })
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "onsails/lspkind.nvim",
      "zbirenbaum/copilot-cmp", -- ADD THIS
    },
    config = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      cmp.setup({
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol",             -- show only symbol annotations
            maxwidth = {
              -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
              -- can also be a function to dynamically calculate max width such as
              -- menu = function() return math.floor(0.45 * vim.o.columns) end,
              menu = 50,                          -- leading text (labelDetails)
              abbr = 50,                          -- actual suggestion item
            },
            ellipsis_char = "...",                -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
            show_labelDetails = true,             -- show labelDetails in menu. Disabled by default

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function(entry, vim_item)
              -- ...
              return vim_item
            end,
          }),
        },
      })
      cmp.setup({
        experimental = {
          ghost_text = true
        },
        snippet = {
          -- Using LuaSnip for snippet expansion
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          -- Uncomment the lines below for bordered windows:
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-s>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-w>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-u>"] = cmp.mapping.scroll_docs(4),
          ["<C-c>"] = cmp.mapping.complete(),
          ["<C-q>"] = cmp.mapping.abort(),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        }),
        formatting = {
          format = lspkind.cmp_format({
            with_text = true,
            menu = {
              nvim_lua = "[api]",
              luasnip = "[snip]",
              nvim_lsp = "[LSP]",
              buffer = "[buf]",
              path = "[path]",
            },
          }),
        },
        sources = cmp.config.sources({
          { name = "copilot", group_index = 2 },
          { name = "nvim_lua", max_item_count = 2 },
          { name = "luasnip" },
          { name = "nvim_lsp", max_item_count = 2 },
          { name = "buffer",   keyword_length = 4, max_item_count = 2 },
        }, {
          { name = "path", max_item_count = 3 },
        }),
      })
    end,
  },
}
