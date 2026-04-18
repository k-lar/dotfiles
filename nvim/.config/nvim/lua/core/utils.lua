---Require a module, returning it on success or nil on failure.
function try_require(mod)
    local ok, result = pcall(require, mod)
    return ok and result or nil
end

function augroup(name)
    return vim.api.nvim_create_augroup("klar_" .. name, { clear = true })
end

is_mac = vim.uv.os_uname().sysname == "Darwin"

local M = {}

---Check if a given filepath is within a specified directory.
---@param filepath string
---@param dir string
---@return boolean
function M.is_in_directory(filepath, dir)
    local expanded_dir = vim.fn.resolve(vim.fn.expand(dir))
    local expanded_filepath = vim.fn.resolve(vim.fn.expand(filepath))

    -- Check if the expanded filepath starts with the expanded directory path
    return expanded_filepath:sub(1, #expanded_dir) == expanded_dir
end

---Trim matching quotes from the start and end of a string.
---@param s string
---@return string
function M.trim_quotes(s)
    return s:match('^"(.*)"$') or s:match("^'(.*)'$") or s
end

return M
