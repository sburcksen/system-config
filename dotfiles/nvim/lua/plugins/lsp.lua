return {
    'neovim/nvim-lspconfig',
    dependencies = {
        { 'hrsh7th/nvim-cmp' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'L3MON4D3/LuaSnip' },
    },
    config = function()
        vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(args)
                local bufnr = args.buf
                local map = function(modes, lhs, rhs, desc)
                    vim.keymap.set(modes, lhs, rhs, { buffer = bufnr, desc = desc })
                end

                -- Default useful keymaps
                map('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
                map('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration')
                map('n', 'gr', vim.lsp.buf.references, 'References')
                map('n', 'gi', vim.lsp.buf.implementation, 'Go to implementation')
                map('n', 'K', vim.lsp.buf.hover, 'Hover docs')
                map('n', '<leader>r', vim.lsp.buf.rename, 'Rename')
                map('n', '<leader>a', vim.lsp.buf.code_action, 'Code action')
                map('n', '<leader>d', vim.diagnostic.open_float, 'Diagnostic float')
                map('n', '[d', vim.diagnostic.goto_prev, 'Prev diagnostic')
                map('n', ']d', vim.diagnostic.goto_next, 'Next diagnostic')

                -- Format keybind
                map({ 'n', 'x' }, 'gf', function()
                    vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
                end, 'Format')

                -- Format on save
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client and client:supports_method('textDocument/formatting') then
                    vim.api.nvim_create_autocmd('BufWritePre', {
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({ bufnr = bufnr, async = false })
                        end,
                    })
                end
            end,
        })

        vim.lsp.config('lua_ls', {
            settings = {
                Lua = {
                    diagnostics = { globals = { 'vim' } },
                },
            },
        })

        vim.lsp.config('clangd', {
            cmd = { 'clangd', '--fallback-style=webkit' },
        })

        vim.lsp.enable({
            'lua_ls',
            'rust_analyzer',
            'clangd',
            'nixd',
            'hls',
        })

        -- Autocompletion
        local cmp = require('cmp')
        cmp.setup({
            sources = {
                { name = 'nvim_lsp' },
                { name = 'path' },
                { name = 'buffer' },
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-Space>'] = cmp.mapping.complete(),
            }),
            preselect = 'item',
            completion = {
                completeopt = 'menu,menuone,noinsert',
            },
        })
    end,
}
