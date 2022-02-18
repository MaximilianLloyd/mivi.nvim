local M = {}

M.example = function()
    print("HI")
end

project_workbench_bufnr = vim.api.nvim_create_buf(false, true)
project_workbench_initialized = false

M.setup = function(opts)
    local ui = vim.api.nvim_list_uis()[1]

    local width = math.floor(ui.width * 0.5)
    local height = math.floor(ui.height * 0.5)

    print(width, height)
    print("Options", opts)
end

print(M.setup())

return M
