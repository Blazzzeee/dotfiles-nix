return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },

  keys = {
    {
      "<leader>b",
      function()
        require("conform").format({ async = true })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },

  ---@type conform.setupOpts
  opts = {
    formatters_by_ft = {
      -- Existing
      lua = { "stylua" },
      python = { "isort", "black" },

      -- JavaScript / TypeScript
      javascript = { "prettierd", "prettier", stop_after_first = true },
      javascriptreact = { "prettierd", "prettier", stop_after_first = true },
      typescript = { "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "prettierd", "prettier", stop_after_first = true },

      -- JSX/TSX (sometimes categorized separately in configs)
      jsx = { "prettierd", "prettier", stop_after_first = true },
      tsx = { "prettierd", "prettier", stop_after_first = true },

      -- Ruby
      ruby = { "rubocop" }, -- OR you can use ruby-lsp, choose one

      -- ERB
      erb = { "erb_format" },
    },

    default_format_opts = {
      lsp_format = "fallback", -- use LSP if no formatter found
    },
  },

  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
