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
                    -- Error = "",
                    -- Error = "",
                    Warn = " ",
                    Hint = " ",
                    -- Hint = " ",
                    -- Hint = "",
                    Info = " ",
                },
                git = {
                    git = "",
                    added = " ",
                    modified = " ",
                    -- modified = "● ",
                    removed = " ",
                    -- removed = " ",
                    renamed = "➜ ",
                    deleted = " ",
                    -- deleted = " ",
                    conflict = "",
                    unstaged = "● ",
                    staged = "✓ ",
                    unmerged = " ",
                    untracked = "★ ",
                    ignored = "◌ ",
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
                file = {
                    arrow_closed = " ",
                    arrow_open = " ",
                    default = " ",
                    open = " ",
                    empty = " ",
                    empty_open = " ",
                    symlink_open = " ",
                    file = " ",
                    symlink = " ",
                    -- symlink = "",
                    file_readonly = " ",
                    file_modified = " ",
                },
                fileformat = {
                    unix = " ",
                    mac = " ",
                    dos = " ",
                },
                filename = {
                    readonly = " ",
                    modified = " ",
                    unnamed = "[No Name]",
                    newfile = "[New]",
                },
                misc = {
                    devil = " ",
                    bsd = " ",
                    ghost = " ",
                },
            },
            -- border used by other plugins
            border = {
                { "🭽", "FloatBorder" },
                { "▔", "FloatBorder" },
                { "🭾", "FloatBorder" },
                { "▕", "FloatBorder" },
                { "🭿", "FloatBorder" },
                { "▁", "FloatBorder" },
                { "🭼", "FloatBorder" },
                { "▏", "FloatBorder" },
            },
        },
    },
}
