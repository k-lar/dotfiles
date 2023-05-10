-- Functions for mapping keys like in vimscript
local function base_map(lhs)
  return function(mode)
    return function(rhs)
      vim.api.nvim_set_keymap(mode, lhs, rhs, {noremap = true, silent = true})
    end
  end
end

local function base_map_opt(lhs)
  return function(mode)
    return function(rhs)
      return function(opts)
        vim.api.nvim_set_keymap(mode, lhs, rhs, opts or {noremap = true, silent = true})
      end
    end
  end
end

function noremap(lhs) return base_map(lhs)('') end
function nnoremap(lhs) return base_map(lhs)('n') end
function inoremap(lhs) return base_map(lhs)('i') end
function vnoremap(lhs) return base_map(lhs)('v') end

function map(lhs) return base_map_opt(lhs)('') end
function nmap(lhs) return base_map_opt(lhs)('n') end

-- Create aliases and functions for better readability
g = vim.g
o = vim.opt
wo = vim.wo
