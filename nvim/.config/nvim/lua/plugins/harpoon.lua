return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            require("harpoon"):setup()
        end,
        -- stylua: ignore
        keys = {
            { "<leader>a", function() require("harpoon"):list():append() end, desc = "Harpoon a file" },
            {
                "<C-e>",
                function()
                    local harpoon = require("harpoon")
                    harpoon.ui:toggle_quick_menu(harpoon:list())
                end,
                desc = "Harpoon quick menu",
            },
            { "<C-1>", function() require("harpoon"):list():select(1) end, desc = "Harpoon to file 1" },
            { "<C-2>", function() require("harpoon"):list():select(2) end, desc = "Harpoon to file 2" },
            { "<C-3>", function() require("harpoon"):list():select(3) end, desc = "Harpoon to file 3" },
            { "<C-4>", function() require("harpoon"):list():select(4) end, desc = "Harpoon to file 4" },
            { "<C-5>", function() require("harpoon"):list():select(5) end, desc = "Harpoon to file 5" },
            { "<C-S-P>", function() require("harpoon"):list():prev() end, desc = "Harpoon to previous file" },
            { "<C-S-N>", function() require("harpoon"):list():next() end, desc = "Harpoon to next file" },
        },
    },
}
