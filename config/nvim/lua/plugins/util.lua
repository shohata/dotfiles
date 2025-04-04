---------------------------------------------------------
-- Util
---------------------------------------------------------

return {
    {
        "snacks.nvim",
        opts = {
            bigfile = { enabled = true },
            quickfile = { enabled = true },
            terminal = {
            win = {
                keys = {
                nav_h = { "<C-h>", function() return term_nav("h") end, desc = "Go to Left Window", expr = true, mode = "t" },
                nav_j = { "<C-j>", function() return term_nav("j") end, desc = "Go to Lower Window", expr = true, mode = "t" },
                nav_k = { "<C-k>", function() return term_nav("k") end, desc = "Go to Upper Window", expr = true, mode = "t" },
                nav_l = { "<C-l>", function() return term_nav("l") end, desc = "Go to Right Window", expr = true, mode = "t" },
                },
            },
            },
        },
        -- stylua: ignore
        keys = {
            { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
            { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
            { "<leader>dps", function() Snacks.profiler.scratch() end, desc = "Profiler Scratch Buffer" },
        },
    },
    {
        "folke/persistence.nvim",
        event = "BufReadPre",
        opts = { options = vim.opt.sessionoptions:get() },
        -- stylua: ignore
        keys = {
            { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
            { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
            { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
        },
    },
    { "nvim-lua/plenary.nvim", lazy = true },
}
