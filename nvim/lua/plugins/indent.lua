return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  config = function()
    local hooks = require("ibl.hooks")

    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      -- NORMAL indent color (subtle grey)
      vim.api.nvim_set_hl(0, "IblIndent", { fg = "#3e4451" })

      -- WHITESPACE (same subtle color)
      vim.api.nvim_set_hl(0, "IblWhitespace", { fg = "#3e4451" })

      -- CURRENT SCOPE (blueish)
      vim.api.nvim_set_hl(0, "IblScope", { fg = "#61afef" })
    end)

    require("ibl").setup({
      indent = {
        char = "│",
        highlight = { "IblIndent" },
      },
      scope = {
        enabled = true,
        highlight = { "IblScope" },
        show_start = false,
        show_end = false,
      },
    })
  end,
  opts = {},
}
