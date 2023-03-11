local theme = require("theme")
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
    "folke/neodev.nvim",
    "tpope/vim-commentary", -- easy commenting
    "tpope/vim-unimpaired", -- bracket mappings for moving between buffers, quickfix items, etc.
    "tpope/vim-surround", -- mappings to easily delete, change and add such surroundings in pairs, such as quotes, parens, etc.
    "tpope/vim-ragtag", -- endings for html, xml, etc. - ehances surround
    "tpope/vim-abolish", -- substitution and abbreviation helpers
    "tpope/vim-repeat", -- enables repeating other supported plugins with the . command
    "tpope/vim-sleuth", -- detect indent style (tabs vs. spaces)
    "mattn/emmet-vim", -- porvide support for expanding abbreviations similar to emmet
    "AndrewRadev/splitjoin.vim", -- single/multi line code handler: gS - split one line into multiple, gJ - combine multiple lines into one
    "editorconfig/editorconfig-vim", -- setup editorconfig
    {
        "itchyny/vim-qfedit", -- freely edit quickfix/location list
        event = "VeryLazy"
    },
    {
        "tpope/vim-fugitive", -- fugitive
        lazy = false,
        keys = {
            {
                "<leader>gr",
                "<cmd>Gread<cr>",
                desc = "read file from git"
             },
            {
                "<leader>gb",
                "<cmd>G blame<cr>",
                desc = "read file from git"
             }
        },
        dependencies = {
            "tpope/vim-rhubarb"
         }
    },

    -- Completions
    ---------------------------------------------------------
    "github/copilot.vim", -- sugget code and entire functions in real-time
    {
        "hrsh7th/nvim-cmp", -- neovim completion
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-vsnip",
            "hrsh7th/vim-vsnip",
            "neovim/nvim-lspconfig" -- configure the neovim LSP client
        },
        config = function()
            require("cmp").setup({
                snippet = {
                    expand = function(args) vim.fn["vsnip#anonymous"](args.body) end
                 }
            })
        end
    },
    {
        "windwp/nvim-autopairs", -- automatically complete brackets/parens/quotes
        config = true
    },

    -- fzf
    ---------------------------------------------------------
    {
        "junegunn/fzf.vim", -- fzf basic wrappper function for neovim
        dependencies = {
            {
                dir = vim.env.HOMEBREW_PREFIX .. "/opt/fzf"
             }
        }
    },

    -- Syntax
    ---------------------------------------------------------
    {
        "ekalinin/Dockerfile.vim", -- syntax for docker
        ft = "Dockerfile"
    },
    {
        "preservim/vim-markdown", -- syntax for markdown
        ft = "markdown",
        dependencies = {
            "godlygeek/tabular"
         }
    },

    -- Snippets
    ---------------------------------------------------------
    {
        "hrsh7th/vim-vsnip-integ", -- provide some plugins integration
        dependencies = {
            "hrsh7th/vim-vsnip"
         }
    },
    {
        "hrsh7th/vim-vsnip", -- vscode snippet features
        config = function()
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
    {
        "jayp0521/mason-null-ls.nvim", -- bridge mson.nvim with the null-ls plugin
        dependencies = {
            "williamboman/mason.nvim", -- manage external editor tools such as LSP servers, DAP servers, linters, etc.
            "jose-elias-alvarez/null-ls.nvim" -- use a language server to inject LSP diagnostics, code actions, etc.
        }
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim"
         }
    },

    -- Appearance
    ---------------------------------------------------------
    "onsails/lspkind.nvim", -- add vscode-like pictograms
    "feline-nvim/feline.nvim", -- show a minimal, stylish and customizable status line
    {
        "stevearc/dressing.nvim", -- improve the default neovim interfaces, such as refactoring
        event = "VeryLazy"
    },
    {
        "startup-nvim/startup.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim"
         }
    },
    {
        "nvim-telescope/telescope.nvim", -- highly extendable fuzzy finder over lists
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "nvim-telescope/telescope-fzf-native.nvim", -- c port of fzf
            "nvim-telescope/telescope-rg.nvim",
            "nvim-telescope/telescope-node-modules.nvim" -- provide node packages
        }
    },
    {
        "nvim-treesitter/nvim-treesitter", -- provide a simple and easy way to use tree-sitter
        build = ":TSUpdate"
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
    },
    {
        "norcalli/nvim-colorizer.lua", -- add color highlighting to hex values
        config = function()
            require("colorizer").setup({
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
            })
        end
    },
    {
        "nvim-neo-tree/neo-tree.nvim", -- browse the file system and other tree like structures
        branch = "v2.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
            "s1n7ax/nvim-window-picker"
        }
    },
    {
        "s1n7ax/nvim-window-picker", -- prompt the user to pick a window and return the window id of the picked window
        config = function()
            require("window-picker").setup({
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
            })
        end
    },
    {
        "alvarosevilla95/luatab.nvim", -- style the tabline without taking over how tabs and buffers work in neovim
        dependencies = {
            "nvim-tree/nvim-web-devicons"
         }
    },
    {
        "folke/trouble.nvim", -- show diagnostics, references, telescope results, quickfix and location lists
        dependencies = {
            "nvim-tree/nvim-web-devicons"
         },
        config = function()
            require("trouble").setup({
                -- your configuration comes here
                -- or leave it empty to use the default settings
            })
        end
    },
    {
        "lewis6991/gitsigns.nvim", -- show git information in the gutter
        config = function() require("gitsigns").setup() end
    },
    {
        "b0o/incline.nvim", -- lightweight floating statuslines, best used neovim's global statusline
        config = {
            hide = {
                cursorline = false,
                focused_win = false,
                only_win = true
             }
        }
    },
    {
        "catppuccin/nvim", -- pastel theme that aims to be the middle ground between low and high contrast themes
        name = "catppuccin",
        lazy = false,
        priority = 1000
    }
}, {
    ui = {
        border = theme.border
     }
})
