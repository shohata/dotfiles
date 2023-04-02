local function lsp_organize_imports()
    local params = {
        command = "_typescript.organizeImports",
        arguments = {
            vim.api.nvim_buf_get_name(0)
        },
        title = ""
    }
    vim.lsp.buf.execute_command(params)
end
-- _G makes this function available to vimscript lua calls
_G.lsp_organize_imports = lsp_organize_imports

-- show diagnostic line with custom border and styling
local function lsp_show_diagnostics()
    vim.diagnostic.open_float({
        border = theme.border
    })
end

local function on_attach(client, bufnr)
    local group = vim.api.nvim_create_augroup("LspConfig", {
        clear = true
    })

    vim.cmd([[command! OR lua lsp_organize_imports()]])
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = theme.border
    })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = theme.border
    })

    local opts = {
        noremap = true,
        silent = true
    }
    vim.keymap.set("n", "<leader>aa", lsp_show_diagnostics, opts)
    vim.keymap.set("n", "gl", lsp_show_diagnostics, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "<leader>aq", vim.diagnostic.setloclist, opts)

    local bufopts = {
        noremap = true,
        silent = true,
        buffer = bufnr
    }
    vim.keymap.set("n", "gO", lsp_organize_imports, bufopts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "go", vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set("n", "gr", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "gR", vim.lsp.buf.references, bufopts)
    vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "S", vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set("n", "ga", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("x", "gA", vim.lsp.buf.range_code_action, bufopts)
    vim.keymap.set("n", "<C-x><C-x>", vim.lsp.buf.signature_help, bufopts)

    if client.server_capabilities.document_highlight then
        vim.api.nvim_create_autocmd("CursorHold", {
            pattern = "*",
            callback = function()
                vim.lsp.buf.document_highlight()
            end,
            group = group
        })
        vim.api.nvim_create_autocmd("CursorMoved", {
            pattern = "*",
            callback = function()
                vim.lsp.buf.clear_references()
            end,
            group = group
        })
    end

    client.server_capabilities.document_formatting = false

    if client.server_capabilities.document_formatting then
        vim.api.nvim_create_autocmd("BufEnter", {
            pattern = "*",
            callback = function()
                vim.lsp.buf.formatting()
            end,
            group = group
        })
    end
end

local function make_config(callback)
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {
            "documentation",
            "detail",
            "additionalTextEdits"
        }
    }
    capabilities.textDocument.colorProvider = {
        dynamicRegistration = false
    }
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    callback = callback or function(config)
        return config
    end

    return callback({
        capabilities = capabilities,
        on_attach = on_attach
    })
end

-- mason-lspconfig options
local opts = {
    ensure_installed = {
        "bashls",
        "denols",
        "eslint",
        "jsonls",
        "lua_ls",
        "rust_analyzer",
        "tsserver",
        "vimls"
    },
    automatic_installation = true,
    ui = {
        check_outdated_servers_on_open = true
    }
}

local function init()
    local ls = {}

    ls.bashls = make_config(function(config)
        return config
    end)

    ls.denols = make_config(function(config)
        config.single_file_support = false
        config.root_dir = require("lspconfig").util.root_pattern("deno.json", "deno.jsonc")
        config.init_options = {
            lint = true
        }
        return config
    end)

    ls.eslint = make_config(function(config)
        config.filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact"
        }
        return config
    end)

    ls.jsonls = make_config(function(config)
        config.filetypes = {
            "json",
            "jsonc"
        }
        return config
    end)

    ls.lua_ls = make_config(function(config)
        config.settings = {
            Lua = {
                runtime = {
                    -- LuaJIT in the case of Neovim
                    version = "LuaJIT",
                    path = vim.split(package.path, ";")
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = {
                        "vim"
                    }
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = {
                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                        [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
                    }
                }
            }
        }
        config.root_dir = function(fname)
            local util = require("lspconfig/util")
            return util.find_git_ancestor(fname) or util.path.dirname(fname)
        end
        config.root_dir = require("lspconfig").util.root_pattern("lua.json")
        return config
    end)

    ls.rust_analyzer = make_config(function(config)
        return config
    end)

    ls.tsserver = make_config(function(config)
        config.root_dir = require("lspconfig").util.root_pattern("tsconfig.json")
        config.handlers = {
            ["textDocument/definition"] = function(err, result, ctx, conf)
                -- if there is more than one result, just use the first one
                if #result > 1 then
                    result = {
                        result[1]
                    }
                end
                vim.lsp.handlers["textDocument/definition"](err, result, ctx, conf)
            end
        }
        return config
    end)

    ls.vimls = make_config(function(config)
        config.init_options = {
            isNeovim = true
        }
        return config
    end)

    local lspconfig = require("lspconfig")
    for k, v in pairs(ls) do
        lspconfig[k].setup(v)
    end
end

return {
    init = init,
    opts = opts
}
