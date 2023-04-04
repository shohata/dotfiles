---------------------------------------------------------
-- Core
---------------------------------------------------------

return {
    {
        "LazyVim/LazyVim",
        opts = {
            -- colorscheme can be a string like `catppuccin` or a function that will load the colorscheme
            ---@type string|fun()
            colorscheme = "catppuccin",
            -- load the default settings
            defaults = {
                autocmds = true, -- lazyvim.config.autocmds
                keymaps = true, -- lazyvim.config.keymaps
                options = true, -- lazyvim.config.options
            },
            -- icons used by other plugins
            icons = {
                diagnostics = {
                    Error = " ",
                    Warn = " ",
                    Hint = " ",
                    Info = " ",
                },
                git = {
                    added = " ",
                    modified = " ",
                    removed = " ",
                },
                kinds = {
                    Array = " ",
                    Boolean = " ",
                    Class = " ",
                    Color = " ",
                    Constant = " ",
                    Constructor = " ",
                    Copilot = " ",
                    Enum = " ",
                    EnumMember = " ",
                    Event = " ",
                    Field = " ",
                    File = " ",
                    Folder = " ",
                    Function = " ",
                    Interface = " ",
                    Key = " ",
                    Keyword = " ",
                    Method = " ",
                    Module = " ",
                    Namespace = " ",
                    Null = " ",
                    Number = " ",
                    Object = " ",
                    Operator = " ",
                    Package = " ",
                    Property = " ",
                    Reference = " ",
                    Snippet = " ",
                    String = " ",
                    Struct = " ",
                    Text = " ",
                    TypeParameter = " ",
                    Unit = " ",
                    Value = " ",
                    Variable = " ",
                },
            },
        },
    },
}
