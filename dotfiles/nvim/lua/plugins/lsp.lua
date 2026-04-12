local lsp_servers = {
    'lua_ls',
    'rust_analyzer',
    'clangd',
    'nixd',
    'hls',
}

local lua_ls_config = {
    settings = {
        Lua = {
            diagnostics = { globals = { 'vim' } },
        }
    }
}

local clangd_config = {
    cmd = {
        "clangd",
        "--fallback-style=webkit"
    }
}

return {
    'VonHeikemen/lsp-zero.nvim',

    dependencies = {
        { 'neovim/nvim-lspconfig' },
        { 'hrsh7th/nvim-cmp' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'L3MON4D3/LuaSnip' },
    },

    config = function()
        local lsp_zero = require('lsp-zero')

        lsp_zero.configure('lua_ls', lua_ls_config)
        lsp_zero.configure('clangd', clangd_config)
        lsp_zero.setup_servers(lsp_servers)

        lsp_zero.on_attach(function(client, bufnr)
            -- see :help lsp-zero-keybindings
            -- to learn the available actions
            lsp_zero.default_keymaps({ buffer = bufnr })

            -- Format on save
            lsp_zero.buffer_autoformat()

            -- Format keybind
            vim.keymap.set({ 'n', 'x' }, 'gf', function()
                vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
            end, { buffer = bufnr, desc = "Auto-Format" })
        end)

        lsp_zero.setup()

        -- Autocompletion
        local cmp = require('cmp')
        cmp.setup({
            sources = {
                { name = "nvim_lsp" },
                { name = "path" },
                { name = "buffer" },
            },

            mapping = cmp.mapping.preset.insert({
                ["<C-Space>"] = cmp.mapping.complete(),
                --['<CR>'] = cmp.mapping.confirm({ select = true }),
            }),

            -- Start completion with first item already preselect
            preselect = 'item',
            completion = {
                completeopt = 'menu,menuone,noinsert'
            },

        })
    end,
}
