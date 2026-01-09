return {
  {
    "saghen/blink.cmp",
    event = "InsertEnter",
    dependencies = {
    },
    config = function ()

       require("blink-cmp").setup({

          sources = {
            default = { "lsp", "path", "snippets", "buffer" },
            providers = {
              lsp = {
                min_keyword_length = 3,
                max_items = 3,
              },
              path = {
                max_items = 3,
                min_keyword_length = 3,
              },
              buffer = {
                min_keyword_length = 3,
                max_items = 3,
              },
              snippets = {
                min_keyword_length = 3,
              },
            },
          },
          completion = {
                keyword = { range = 'prefix'},
                accept = { auto_brackets = { enabled = true }, },
            menu = {
              draw = {
                columns = {
                  { "label", "label_description", gap = 1 },
                  { "kind" },
                },
              },
            },
          }
    })
    end
    }
}
