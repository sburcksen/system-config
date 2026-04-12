return {
    "theprimeagen/harpoon",

    config = function()
        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")

        vim.keymap.set("n", "<leader>a", mark.add_file, {
            desc = "Add file (harpoon)"
        })

        vim.keymap.set("n", "<leader>h", ui.toggle_quick_menu, {
            desc = "Open UI (harpoon)"
        })

        vim.keymap.set("n", "<leader>n", function() ui.nav_file(1) end, {
            desc = "Open file 1 (harpoon)"
        })
        vim.keymap.set("n", "<leader>e", function() ui.nav_file(2) end, {
            desc = "Open file 2 (harpoon)"
        })
        vim.keymap.set("n", "<leader>i", function() ui.nav_file(3) end, {
            desc = "Open file 3 (harpoon)"
        })
        vim.keymap.set("n", "<leader>o", function() ui.nav_file(4) end, {
            desc = "Open file 4 (harpoon)"
        })
    end
}
