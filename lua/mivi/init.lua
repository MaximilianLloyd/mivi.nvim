local popup = require("plenary.popup")
local json = require("plenary.json")
local curl = require("plenary.curl")
-- local http_request = require "http.request"

local M = {}
local config = {}

M.setup = function(options)
    local default_options = {

    }
    config = options
end

M.create_window = function(_opts, items)
    local options = {} or _opts
    local bufnr = vim.api.nvim_create_buf(false, true)

    vim.api.nvim_buf_set_lines(bufnr, 0, -1, true, items)
    local borderchars = options.borderchars or { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }

    local width = config.width or 60
    local height = config.height or 10

    local Mivi_win_id, win = popup.create(bufnr, {
        title = "Mivi",
        highlight = "MiviWindow",
        borderchars = borderchars,
        line = math.floor(((vim.o.lines - height) / 2) - 1),
        col = math.floor((vim.o.columns - width) / 2),
        width = 60,
        minheight = 20,
        -- height = 10,
    })

    vim.api.nvim_buf_set_option(bufnr, "buftype", "acwrite")
    vim.api.nvim_buf_set_option(bufnr, "bufhidden", "wipe")
    vim.api.nvim_buf_set_option(bufnr, "modifiable", false)


    local response = {
        bufnr = bufnr,
        win_id = Mivi_win_id,
    }

    return response
end

M.close = function(win_id)
    vim.api.nvim_win_close(win_id, true)
end

res = curl.request({
    url = "https://jsonplaceholder.typicode.com/todos/1",
    method = "get",
    accept = "application/json"
})

local result = vim.fn.json_decode(res.body)
local items = { "First", "second", "third" }
local win_info = M.create_window({}, { result.title })

-- local headers, stream = assert(http_request.new_from_uri("https://jsonplaceholder.typicode.com/todos/1"):go())
-- local body = assert(stream:get_body_as_string())
-- if headers:get ":status" ~= "200" then
--     error(body)
-- end
-- print(body)

vim.keymap.set("n", "mc", function()
    print("Calling close")
    M.close(win_info.win_id)
end, { noremap = true, silent = true })

