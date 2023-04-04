---------------------------------------------------------
-- Catppuccin
---------------------------------------------------------

return {
    {
        -- pastel theme that aims to be the middle ground between low and high contrast themes
        "catppuccin/nvim",
        name = "catppuccin",
        cond = not vim.g.vscode,
        lazy = true,
        opts = {
            flavour = vim.env.THEME_FLAVOUR, -- latte, frappe, macchiato, mocha
            background = { -- :h background
                light = vim.env.THEME_FLAVOUR,
                dark = vim.env.THEME_FLAVOUR,
            },
            transparent_background = true,
            show_end_of_buffer = false, -- show the '~' characters after the end of buffers
            term_colors = true,
            dim_inactive = {
                enabled = false,
                shade = "dark",
                percentage = 0.15,
            },
            no_italic = false, -- Force no italic
            no_bold = false, -- Force no bold
            styles = {
                comments = { "italic" },
                conditionals = { "italic" },
                loops = {},
                functions = { "bold" },
                keywords = {},
                strings = {},
                variables = {},
                numbers = {},
                booleans = {},
                properties = {},
                types = {},
                operators = {},
            },
            color_overrides = {},
            custom_highlights = {},
            integrations = {
                native_lsp = {
                    enabled = true,
                    virtual_text = {
                        errors = { "italic" },
                        hints = { "italic" },
                        warnings = { "italic" },
                        information = { "italic" },
                    },
                    underlines = {
                        errors = { "underline" },
                        hints = { "underline" },
                        warnings = { "underline" },
                        information = { "underline" },
                    },
                },
                indent_blankline = {
                    enabled = true,
                    colored_indent_levels = false,
                },
                cmp = true,
                gitsigns = true,
                leap = true,
                lsp_trouble = true,
                markdown = true,
                mason = true,
                neotree = true,
                notify = true,
                telescope = true,
                treesitter = true,
                which_key = true,
            },
        },
    },
}
