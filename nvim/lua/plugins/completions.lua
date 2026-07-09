return {
    {
        "saghen/blink.cmp",
        event = "InsertEnter",
        dependencies = {
            'rafamadriz/friendly-snippets',
            'saghen/blink.lib'
        },
        config = function()
            require("blink.cmp").setup({

                fuzzy = {
                    implementation = "lua",
                },

                sources = {
                    default = { "lsp", "path", "snippets", "buffer" },
                    providers = {
                        lsp = {
                            max_items = 3,
                        },
                        path = {
                            max_items = 3,
                        },
                        buffer = {
                            max_items = 3,
                        },
                        snippets = {
                        },
                    },
                },
                completion = {
                    ghost_text = { enabled = true },
                    keyword = { range = 'prefix' },
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
