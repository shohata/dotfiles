---------------------------------------------------------
-- Coding
---------------------------------------------------------

return {
    {
        "tzachar/cmp-tabnine",
        build = "./install.sh",
        dependencies = "hrsh7th/nvim-cmp",
        opts = {
            max_lines = 1000,
            max_num_results = 20,
            sort = true,
            run_on_every_keystroke = true,
            snippet_placeholder = "..",
            ignored_file_types = {
                -- default is not to ignore
                -- uncomment to ignore in lua:
                -- lua = true
            },
            show_prediction_strength = false,
        },
    },
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp"
    },
    {
        "rafamadriz/friendly-snippets",
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },
    { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
    { 'echasnovski/mini.nvim', version = '*' },
    { 'echasnovski/mini.ai', version = '*' },
}
