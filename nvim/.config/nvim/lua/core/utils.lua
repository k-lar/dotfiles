local M = {}

function M.is_in_directory(filepath, dir)
    local expanded_dir = vim.fn.resolve(vim.fn.expand(dir))
    local expanded_filepath = vim.fn.resolve(vim.fn.expand(filepath))

    -- Check if the expanded filepath starts with the expanded directory path
    return expanded_filepath:sub(1, #expanded_dir) == expanded_dir
end

function M.trim_quotes(s)
    return s:match('^"(.*)"$') or s:match("^'(.*)'$") or s
end

return M
