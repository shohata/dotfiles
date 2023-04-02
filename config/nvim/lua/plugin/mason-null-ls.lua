local function init()
    local null_ls = require("null-ls")

    require("mason-null-ls").setup_handlers({
        function(source_name, methods)
            require("mason-null-ls.automatic_setup")(source_name, methods)
        end,
        prettier = function()
            null_ls.register(null_ls.builtins.formatting.prettier.with({
                filetypes = {
                    "javascript",
                    "javascriptreact",
                    "typescript",
                    "typescriptreact",
                    "css",
                    "scss",
                    "json",
                    "graphql",
                    "markdown",
                    "yaml",
                    "html",
                    "vue",
                    "lua"
                },
                args = {
                    "--stdin-filepath",
                    vim.api.nvim_buf_get_name(0)
                }
            }))
        end
    })
end

local opts = {
    automatic_setup = true,
    ensure_installed = {
        "stylua",
        "prettierd"
    }
}

return {
    init = init,
    opts = opts
}
