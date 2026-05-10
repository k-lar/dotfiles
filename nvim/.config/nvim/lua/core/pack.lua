if not vim.pack then
    return
end

-- Build hooks must be registered before vim.pack.add()
vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
            vim.schedule(function() vim.cmd("TSUpdate") end)
        end
    end,
})

vim.pack.add({
    { src = "https://github.com/echasnovski/mini.pick" },
    { src = "https://github.com/echasnovski/mini.move" },
    { src = "https://github.com/echasnovski/mini.comment" },
    { src = "https://github.com/echasnovski/mini.indentscope" },
    { src = "https://github.com/echasnovski/mini.surround" },
    { src = "https://github.com/echasnovski/mini.icons" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/github/copilot.vim" },
    { src = "https://github.com/dhruvasagar/vim-table-mode" },
    { src = "https://github.com/dkarter/bullets.vim" },
    { src = "https://github.com/k-lar/dynomark.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
    { src = "https://github.com/folke/which-key.nvim" },
    { src = "https://github.com/saghen/blink.cmp", version = "v1" },
    { src = "https://github.com/moyiz/blink-emoji.nvim" },
    { src = "https://github.com/danymat/neogen" },
    { src = "https://github.com/folke/flash.nvim" },
    { src = "https://github.com/folke/todo-comments.nvim" },
    { src = "https://github.com/brenoprata10/nvim-highlight-colors" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/williamboman/mason.nvim" },
    { src = "https://github.com/williamboman/mason-lspconfig.nvim" },
    { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
    { src = "https://github.com/j-hui/fidget.nvim" },
    { src = "https://github.com/folke/lazydev.nvim" },
    { src = "https://github.com/Bilal2453/luvit-meta" },
    { src = "https://github.com/k-lar/dark-pale-gruvbox-lualine.nvim" },
    { src = "https://github.com/nvim-lualine/lualine.nvim" },
    { src = "https://github.com/akinsho/toggleterm.nvim" },
    { src = "https://github.com/mluders/comfy-line-numbers.nvim" },
})

-- Some intuitive helper commands for vim.pack
local function complete_packages(match)
  return vim.iter(vim.pack.get())
    :map(function(pack) return pack.spec.name end)
    :filter(function(pack) return pack:find(match) end)
    :totable()
end

vim.api.nvim_create_user_command(
  'Pack',
  function(info)
    local subcmd = info.fargs[1]
    local args = vim.list_slice(info.fargs, 2)

    if subcmd == 'update' then
      vim.pack.update(#args > 0 and args or nil, {
        force = info.bang,
      })

    elseif subcmd == 'delete' then
      if #args == 0 then
        vim.notify(
          'Pack delete requires at least one package',
          vim.log.levels.ERROR
        )
        return
      end

      vim.pack.del(args, {
        force = info.bang,
      })

    elseif subcmd == 'install' then
      if #args == 0 then
        vim.notify(
          'Pack install requires at least one source',
          vim.log.levels.ERROR
        )
        return
      end

      local specs = vim.iter(args)
        :map(function(src)
          return { src = src }
        end)
        :totable()

      vim.pack.add(specs, {
        confirm = not info.bang,
      })

    else
      vim.notify(
        ('Unknown Pack subcommand: %s'):format(subcmd or ''),
        vim.log.levels.ERROR
      )
    end
  end,
  {
    desc = 'Manage packages',
    nargs = '+',
    bang = true,
    complete = function(arglead, cmdline)
      local parts = vim.split(cmdline, '%s+')

      -- Complete subcommands
      if #parts <= 2 then
        return vim.tbl_filter(function(cmd)
          return cmd:find(arglead) == 1
        end, {
          'update',
          'delete',
          'install',
        })
      end

      local subcmd = parts[2]

      -- Package completion for update/delete
      if subcmd == 'update' or subcmd == 'delete' then
        return complete_packages(arglead)
      end

      -- No completion for install sources
      return {}
    end,
  }
)
