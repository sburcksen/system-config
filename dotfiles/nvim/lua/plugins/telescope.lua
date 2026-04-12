return {
    "nvim-telescope/telescope.nvim",

    dependencies = {
        "nvim-lua/plenary.nvim",
    },

    config = function()
        local telescope = require('telescope')
        local builtin = require('telescope.builtin')

        telescope.setup {
            pickers = {
                find_files = {
                    hidden = true
                }
            }
        }

        vim.keymap.set('n', '<leader>ff', builtin.find_files, {
            desc = 'Telescope'
        })
        vim.keymap.set('n', '<leader>ps',
            function()
                builtin.grep_string({ search = vim.fn.input("Grep > ") });
            end,
            { desc = 'Search file contents (telescope)' }
        )
    end
}
