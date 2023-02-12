local packerpath = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if not vim.loop.fs_stat(packerpath) then
  vim.fn.system({
    "git",
    "clone",
    "--depth=1",
    "https://github.com/wbthomason/packer.nvim",
    packerpath,
  })
end
vim.opt.rtp:prepend(packerpath)

return require("packer").startup(function(use)
  use({
    {
      "wbthomason/packer.nvim", -- package manager
      opt = true,
    },
    "tpope/vim-commentary", -- easy commenting
    "tpope/vim-unimpaired", -- bracket mappings for moving between buffers, quickfix items, etc.
    "tpope/vim-surround", -- mappings to easily delete, change and add such surroundings in pairs, such as quotes, parens, etc.
    "tpope/vim-ragtag", -- endings for html, xml, etc. - ehances surround
    "tpope/vim-abolish", -- substitution and abbreviation helpers
    "tpope/vim-repeat", -- enables repeating other supported plugins with the . command
    "tpope/vim-sleuth", -- detect indent style (tabs vs. spaces)
    "tpope/vim-fugitive", -- fugitive
    "mattn/emmet-vim", -- porvide support for expanding abbreviations similar to emmet
    "editorconfig/editorconfig-vim", -- setup editorconfig
    "itchyny/vim-qfedit", -- freely edit quickfix/location list
    "AndrewRadev/splitjoin.vim", -- single/multi line code handler: gS - split one line into multiple, gJ - combine multiple lines into one
    {
      "ekalinin/Dockerfile.vim", -- syntax for docker
      ft = "Dockerfile",
    },
    {
      "preservim/vim-markdown", -- syntax for markdown
      ft = "markdown",
      requires = {
        "godlygeek/tabular",
      },
    },
    {
      "hrsh7th/vim-vsnip-integ", -- provide some plugins integration
      requires = {
        "hrsh7th/vim-vsnip",
      },
    },
    {
      "hrsh7th/vim-vsnip", -- vscode snippet features
      config = function()
        local snippet_dir = os.getenv("DOTFILES") .. "/config/nvim/snippets"
        vim.g.vsnip_snippet_dir = snippet_dir
        vim.g.vsnip_filetypes = {
          javascriptreact = { "javascript" },
          typescriptreact = { "typescript" },
        }
      end,
    },
    {
      "norcalli/nvim-colorizer.lua", -- add color highlighting to hex values
      config = function()
        require("colorizer").setup({ "*" }, {
          RGB = true,
          RRGGBB = true,
          names = true,
          RRGGBBAA = true,
          rgb_fn = true,
          hsl_fn = true,
          css = true,
          css_fn = true
        })
      end,
    },
    {
      "nvim-neo-tree/neo-tree.nvim", -- browse the file system and other tree like structures
      branch = "v2.x",
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
        "s1n7ax/nvim-window-picker",
      },
    },
    {
      "s1n7ax/nvim-window-picker",
      tag = "v1.*",
      config = function()
        require("window-picker").setup({
          autoselect_one = true,
          include_current = false,
          filter_rules = {
            bo = {
              filetype = { "nep-tree", "neo-tree-popup", "notify" },
              buftype = { "terminal", "quickfix" },
            },
          },
          border = {
            style = "rounded",
            highlight = "Normal",
          },
          other_win_hl_color = "#e35e4f",
        })
      end,
    },
    {
      "lewis6991/gitsigns.nvim", -- show git information in the gutter
      config = function()
        require("gitsigns").setup()
      end,
    },
    {
      "williamboman/mason.nvim", -- manage external editor tools such as LSP servers, DAP servers, linters, etc.
      config = function()
        require("mason").setup()
      end,
    },
    {
      "jayp0521/mason-null-ls.nvim", -- bridge mson.nvim with the null-ls plugin
      after = "mason.nvim",
      config = function()
        require("mason-null-ls").setup({
          ensure_installed = {
            -- Opt to list sources here, when available in mason.
            "stylua",
            "jq",
          },
          automatic_installation = false,
          automatic_setup = true, -- Recommended, but optional
        })
      end,
    },
    {
      "jose-elias-alvarez/null-ls.nvim", -- use a language server to inject LSP diagnostics, code actions, etc.
      after = "mason-null-ls.nvim",
      config = function()
        require("null-ls").setup({
          sources = {
            -- Anything not supported by mason.
          },
        })
      end,
    },
    {
      "neovim/nvim-lspconfig",
      requires = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
      },
    },
    {
      "hrsh7th/nvim-cmp", -- neovim completion
      requires = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-vsnip",
        "hrsh7th/vim-vsnip",
        "neovim/nvim-lspconfig", -- configure the neovim LSP client
      },
      config = function()
        require("cmp").setup({
          snippet = {
            expand = function(args)
              vim.fn["vsnip#anonymous"](args.body)
            end,
          },
        })
      end,
    },
    {
      "nvim-treesitter/nvim-treesitter", -- provide a simple and easy way to use tree-sitter
      run = ":TSUpdate",
    },
    "onsails/lspkind-nvim", -- add vscode-like pictograms
    "feline-nvim/feline.nvim", -- show a minimal, stylish and customizable status line
    {
      "windwp/nvim-autopairs", -- automatically complete brackets/parens/quotes
      config = function()
        require("nvim-autopairs").setup({})
      end,
    },
    {
      "alvarosevilla95/luatab.nvim", -- style the tabline without taking over how tabs and buffers work in neovim
      requires = {
        "kyazdani42/nvim-web-devicons",
      },
    },
    "github/copilot.vim", -- enable copilot support for neovim
    "stevearc/dressing.nvim", -- improve the default neovim interfaces, such as refactoring
    {
      "nvim-telescope/telescope.nvim", -- highly extendable fuzzy finder over lists
      tag = "0.1.1",
      requires = {
        "nvim-lua/plenary.nvim",
      }
    },
    "startup-nvim/startup.nvim", -- fully customizable greeter for neovim
    {
      "junegunn/fzf", -- fzf
      run = ":call fzf#install()",
    },
    {
      "junegunn/fzf.vim", -- basic wrappper function for neovim
      requires = {
        "junegunn/fzf",
      },
    },
    {
      "folke/trouble.nvim", -- show diagnostics, references, telescope results, quickfix and location lists
      requires = "nvim-tree/nvim-web-devicons",
      config = function()
        require("trouble").setup {
          -- your configuration comes here
          -- or leave it empty to use the default settings
        }
      end
    },
    {
      "catppuccin/nvim", -- pastel theme that aims to be the middle ground between low and high contrast themes
      as = "catppuccin",
    },
    {
      "b0o/incline.nvim", -- lightweight floating statuslines, best used neovim's global statusline
      config = function()
        require("incline").setup({
          hide = {
            cursorline = false,
            focused_win = false,
            only_win = true,
          }
        })
      end,
    },
  })
end)
