local popup = require("plenary.popup")


local M = {}
local config = {}

M.create_window = function(_opts)
    local opts = _opts or {}


    local bufnr = vim.api.nvim_create_buf(false, true)

    local borderchars = opts.borderchars or { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }

    local width = config.width or 60
    local height = config.height or 10

    local Mivi_win_id, win = popup.create(bufnr, {
        title = "Mivi",
        highlight = "MiviWindow",
        borderchars = borderchars,
        line = math.floor(((vim.o.lines - height) / 2) - 1),
        col = math.floor((vim.o.columns - width) / 2),
        width = 60,
        height = 10,
    })

    local response = {
        bufnr = bufnr,
        win_id = Mivi_win_id,
    }

    return response
end

M.close = function(win_id)
    vim.api.nvim_win_close(win_id, true)
end

local items = { "first", "second", "third" }
local win_info = M.create_window()

vim.api.nvim_win_set_option(win_info.win_id, "number", true)
vim.api.nvim_win_set_height(win_info.win_id, 10)


vim.api.nvim_buf_set_option(win_info.bufnr, "buftype", "acwrite")
vim.api.nvim_buf_set_option(win_info.bufnr, "bufhidden", "wipe")

vim.api.nvim_buf_set_lines(win_info.bufnr, 0, -1, true, items)

vim.keymap.set("n", "mc", function()
    print("Calling close")
    M.close(win_info.win_id)
end, { noremap = true, silent = true })

