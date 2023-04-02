local theme = require("theme")

local function init()
    vim.opt.completeopt = "menu,menuone,noselect"

    -- Set colors for completion items
    local cmp_cmd = {
        "highlight! CmpItemAbbrMatch guibg=NONE guifg=" .. theme.colors.lightblue,
        "highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=" .. theme.colors.lightblue,
        "highlight! CmpItemKindFunction guibg=NONE guifg=" .. theme.colors.magenta,
        "highlight! CmpItemKindMethod guibg=NONE guifg=" .. theme.colors.magenta,
        "highlight! CmpItemKindVariable guibg=NONE guifg=" .. theme.colors.blue,
        "highlight! CmpItemKindKeyword guibg=NONE guifg=" .. theme.colors.fg
    }

    for k, v in pairs(cmp_cmd) do
        vim.cmd(v)
    end
end

local function config()
    local cmp = require("cmp")
    cmp.setup({
        snippet = {
            expand = function(args)
                vim.fn["vsnip#anonymous"](args.body)
            end
        },
        mapping = {
            ["<C-j>"] = cmp.mapping.select_next_item({
                behavior = cmp.SelectBehavior.Insert
            }),
            ["<C-k>"] = cmp.mapping.select_prev_item({
                behavior = cmp.SelectBehavior.Insert
            }),
            ["<C-d>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.close(),
            ["<CR>"] = cmp.mapping.confirm({
                select = true
            })
        },
        sources = cmp.config.sources({
            {
                name = "vsnip"
            },
            {
                name = "nvim_lua"
            },
            {
                name = "nvim_lsp"
            },
            {
                name = "buffer",
                keyword_length = 5,
                max_item_count = 5
            },
            {
                name = "path"
            },
            {
                name = "cmdline"
            }
        }),
        formatting = {
            format = require("lspkind").cmp_format {
                with_text = true,
                menu = {
                    nvim_lsp = "ﲳ",
                    nvim_lua = "",
                    path = "ﱮ",
                    buffer = "﬘",
                    vsnip = ""
                    -- treesitter = "",
                    -- zsh = "",
                    -- spell = "暈"
                }
            }
        },
        experimental = {
            native_menu = false,
            ghost_text = true
        }
    })
end

return {
    init = init,
    config = config
}
