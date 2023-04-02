local theme = require("theme")
local plugin = require("plugin")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

return require("lazy").setup({
    -- General
    ---------------------------------------------------------
    -- easy commenting
    {
        "tpope/vim-commentary"
    },

    -- bracket mappings for moving between buffers, quickfix items, etc.
    {
        "tpope/vim-unimpaired"
    },

    -- mappings to easily delete, change and add such surroundings in pairs, such as quotes, parens, etc.
    {
        "tpope/vim-surround"
    },

    -- endings for html, xml, etc. - ehances surround
    {
        "tpope/vim-ragtag"
    },

    -- substitution and abbreviation helpers
    {
        "tpope/vim-abolish"
    },

    -- enables repeating other supported plugins with the . command
    {
        "tpope/vim-repeat"
    },

    -- detect indent style (tabs vs. spaces)
    {
        "tpope/vim-sleuth"
    },

    -- porvide support for expanding abbreviations similar to emmet
    {
        "mattn/emmet-vim"
    },

    -- single/multi line code handler: gS - split one line into multiple, gJ - combine multiple lines into one
    {
        "AndrewRadev/splitjoin.vim"
    },

    -- setup editorconfig
    {
        "editorconfig/editorconfig-vim"
    },

    -- automatically complete brackets/parens/quotes
    {
        "windwp/nvim-autopairs",
        config = true
    },

    -- freely edit quickfix/location list
    {
        "itchyny/vim-qfedit",
        event = "VeryLazy"
    },

    -- fugitive
    {
        "tpope/vim-fugitive",
        lazy = false,
        dependencies = {
            "tpope/vim-rhubarb"
        },
        keys = {
            {
                "<Leader>gr",
                "<Cmd>Gread<CR>",
                desc = "read file from git"
            },
            {
                "<Leader>gb",
                "<Cmd>G blame<CR>",
                desc = "read file from git"
            }
        }
    },

    -- Completions
    ---------------------------------------------------------
    -- sugget code and entire functions in real-time
    {
        "github/copilot.vim"
    },

    -- neovim completion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-vsnip",
            "onsails/lspkind.nvim",
            {
                "roobert/tailwindcss-colorizer-cmp.nvim",
                config = true
            }
        },
        init = plugin.cmp.init,
        config = plugin.cmp.config
    },

    -- fzf
    ---------------------------------------------------------
    -- fzf basic wrappper function for neovim
    {
        "junegunn/fzf.vim",
        dependencies = {
            {
                dir = vim.env.HOMEBREW_PREFIX .. "/opt/fzf"
            }
        },
        keys = plugin.fzf.keys,
        init = plugin.fzf.init
    },

    -- Syntax
    ---------------------------------------------------------
    -- syntax for docker
    {
        "ekalinin/Dockerfile.vim",
        ft = "Dockerfile"
    },

    -- syntax for markdown
    {
        "preservim/vim-markdown",
        ft = "markdown",
        dependencies = {
            "godlygeek/tabular"
        }
    },

    -- Snippets
    ---------------------------------------------------------
    -- provide some plugins integration
    {
        "hrsh7th/vim-vsnip-integ",
        dependencies = {
            "hrsh7th/vim-vsnip"
        }
    },

    -- vscode snippet features
    {
        "hrsh7th/vim-vsnip",
        init = function()
            vim.g.vsnip_snippet_dir = os.getenv("DOTFILES") .. "/config/nvim/snippets"
            vim.g.vsnip_filetypes = {
                javascriptreact = {
                    "javascript"
                },
                typescriptreact = {
                    "typescript"
                }
            }
        end
    },

    -- Language Serveer Protocol (LSP)
    ---------------------------------------------------------
    -- manage external editor tools such as LSP servers, DAP servers, linters, etc.
    {
        "williamboman/mason.nvim",
        cond = not vim.g.vscode,
        opts = {
            ui = {
                border = theme.border
            }
        }
    },

    -- bridge mson.nvim with the null-ls plugin
    {
        "jayp0521/mason-null-ls.nvim",
        cond = not vim.g.vscode,
        dependencies = {
            "williamboman/mason.nvim",
            "jose-elias-alvarez/null-ls.nvim" -- use a language server to inject LSP diagnostics, code actions, etc.
        },
        init = (not vim.g.vscode) and plugin.mason_null_ls.init,
        opts = plugin.mason_null_ls.opts
    },

    -- configure the neovim LSP client
    {
        "neovim/nvim-lspconfig",
        cond = not vim.g.vscode,
        lazy = false,
        dependencies = {
            "folke/neodev.nvim", -- setup for init.lua and plugin development with full signature help
            "hrsh7th/cmp-nvim-lsp",
            "williamboman/mason.nvim",
            {
                "williamboman/mason-lspconfig.nvim",
                opts = plugin.lspconfig.opts
            }
        },
        init = (not vim.g.vscode) and plugin.lspconfig.init
    },

    -- Appearance
    ---------------------------------------------------------
    -- add vscode-like pictograms
    {
        "onsails/lspkind.nvim"
    },

    -- improve the default neovim interfaces, such as refactoring
    {
        "stevearc/dressing.nvim",
        cond = not vim.g.vscode,
        event = "VeryLazy"
    },

    {
        "startup-nvim/startup.nvim",
        cond = not vim.g.vscode,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim"
        },
        init = (not vim.g.vscode) and plugin.startup.init,
        opts = plugin.startup.opts
    },

    -- highly extendable fuzzy finder over lists
    {
        "nvim-telescope/telescope.nvim",
        cond = not vim.g.vscode,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "nvim-telescope/telescope-fzf-native.nvim", -- c port of fzf
            "nvim-telescope/telescope-rg.nvim",
            "nvim-telescope/telescope-node-modules.nvim" -- provide node packages
        },
        keys = plugin.telescope.keys,
        init = (not vim.g.vscode) and plugin.telescope.init,
        config = plugin.telescope.config
    },

    -- provide a simple and easy way to use tree-sitter
    {
        "nvim-treesitter/nvim-treesitter",
        cond = not vim.g.vscode,
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/playground", -- show treesitter nodes
            "nvim-treesitter/nvim-treesitter-textobjects", -- show treesitter nodes
            "p00f/nvim-ts-rainbow", -- add rainbow highlighting to parens and brackets
            "JoosepAlviste/nvim-ts-context-commentstring"
        },
        opts = plugin.treesitter.opts
    },

    {
        "nvim-telescope/telescope-fzf-native.nvim",
        cond = not vim.g.vscode,
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
    },

    -- add color highlighting to hex values
    {
        "NvChad/nvim-colorizer.lua",
        cond = not vim.g.vscode,
        opts = {
            filetypes = {
                "*"
            },
            user_default_options = {
                mode = "background",
                tailwind = true,
                RGB = true,
                RRGGBB = true,
                names = true,
                RRGGBBAA = true,
                rgb_fn = true,
                hsl_fn = true,
                css = true,
                css_fn = true
            }
        }
    },

    -- browse the file system and other tree like structures
    {
        "nvim-neo-tree/neo-tree.nvim",
        cond = not vim.g.vscode,
        branch = "v2.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
            "s1n7ax/nvim-window-picker"
        },
        keys = plugin.neo_tree.keys,
        opts = plugin.neo_tree.opts
    },

    -- prompt the user to pick a window and return the window id of the picked window
    {
        "s1n7ax/nvim-window-picker",
        cond = not vim.g.vscode,
        opts = {
            autoselect_one = true,
            include_current = false,
            filter_rules = {
                bo = {
                    filetype = {
                        "nep-tree",
                        "neo-tree-popup",
                        "notify"
                    },
                    buftype = {
                        "terminal",
                        "quickfix"
                    }
                }
            },
            border = {
                style = "rounded",
                highlight = "Normal"
            },
            other_win_hl_color = "#e35e4f"
        }
    },

    -- style the tabline without taking over how tabs and buffers work in neovim
    {
        "alvarosevilla95/luatab.nvim",
        cond = not vim.g.vscode,
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        }
    },

    -- show diagnostics, references, telescope results, quickfix and location lists
    {
        "folke/trouble.nvim",
        cond = not vim.g.vscode,
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        keys = {
            {
                "<Leader>xx",
                "<Cmd>TroubleToggle<CR>"
            },
            {
                "<Leader>xw",
                "<Cmd>TroubleToggle workspace_diagnostics<CR>"
            },
            {
                "<Leader>xd",
                "<Cmd>TroubleToggle document_diagnostics<CR>"
            },
            {
                "<Leader>xq",
                "<Cmd>TroubleToggle quickfix<CR>"
            },
            {
                "<Leader>xl",
                "<Cmd>TroubleToggle loclist<CR>"
            }
        },
        config = true
    },

    -- show git information in the gutter
    {
        "lewis6991/gitsigns.nvim",
        cond = not vim.g.vscode,
        opts = plugin.gitsigns.opts
    },

    -- lightweight floating statuslines, best used neovim's global statusline
    {
        "b0o/incline.nvim",
        cond = not vim.g.vscode,
        opts = {
            hide = {
                cursorline = false,
                focused_win = false,
                only_win = true
            }
        }
    },

    -- pastel theme that aims to be the middle ground between low and high contrast themes
    {
        "catppuccin/nvim",
        cond = not vim.g.vscode,
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        dependencies = {
            "feline-nvim/feline.nvim" -- show a minimal, stylish and customizable status line
        },
        init = (not vim.g.vscode) and plugin.catppuccin.init,
        opts = plugin.catppuccin.opts
    }
}, {
    ui = {
        border = theme.border
    }
})
