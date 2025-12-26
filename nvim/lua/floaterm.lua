vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { noremap = true })

local state = {
    floating = {
        buf = -1,
        win = -1,
    },
}
local function CreateFloatingWindow(opts)
    opts = opts or {}
    local buf = nil

    if vim.api.nvim_buf_is_valid(opts.buf) then
        buf = opts.buf
    else
        buf = vim.api.nvim_create_buf(false, true)
    end

    -- Create a floating window

    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    local opts = {
        relative = "editor",
        row = row,
        col = col,
        width = width,
        height = height,
        border = "rounded",
        style = "minimal",
    }

    -- Create buffer and window
    local win = vim.api.nvim_open_win(buf, true, opts)

    return { buf = buf, win = win }
end

local function toggle_term()
    if not vim.api.nvim_win_is_valid(state.floating.win) then
        state.floating = CreateFloatingWindow({ buf = state.floating.buf })
        if vim.bo[state.floating.buf].buftype ~= "terminal" then
            vim.cmd.term()
        end
    else
        vim.api.nvim_win_hide(state.floating.win)
    end
end

vim.keymap.set({ "n", "t" }, "<leader>t", toggle_term, {desc="Toggle terminal"})
