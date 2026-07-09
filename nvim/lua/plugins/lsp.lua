return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local servers = {
                clangd = {},
                lua_ls = {},
                pyright = {},
                ts_ls = {},
                eslint = {
                    settings = {
                        workingDirectory = { mode = "auto" },
                    },
                },
                ruby_lsp = {},
                nil_ls = {},
                gopls = {},
            }

            local on_attach = function(client, bufnr)
                if client.name == "ts_ls" then
                    client.server_capabilities.documentFormattingProvider = false
                end

                vim.keymap.set("n", "<leader>n", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename symbol" })
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code actions" })
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition" })
                vim.keymap.set("n", "gk", vim.lsp.buf.hover, { buffer = bufnr, desc = "Symbol info" })
                vim.keymap.set("n", "<leader>q", function()
                    vim.diagnostic.setqflist()
                end, { buffer = bufnr, desc = "Diagnostics to quickfix list" })
            end

            -- Setup servers
            for server, settings in pairs(servers) do
                vim.lsp.config(server, {
                    on_attach = on_attach,
                    settings = settings,
                })

                vim.lsp.enable(server)
            end

            -- Emmet (manual config)
            vim.lsp.config("emmet_language_server", {
                filetypes = {
                    "css", "eruby", "html", "javascript", "javascriptreact",
                    "less", "sass", "scss", "pug", "typescriptreact",
                },
                init_options = {
                    includeLanguages = {},
                    excludeLanguages = {},
                    extensionsPath = {},
                    preferences = {},
                    showAbbreviationSuggestions = true,
                    showExpandedAbbreviation = "always",
                    showSuggestionsAsSnippets = false,
                    syntaxProfiles = {},
                    variables = {},
                },
            })

            vim.lsp.enable("emmet_language_server")
        end,
    },
}
