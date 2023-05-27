-- This file is automatically loaded by plugins.config

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

-- General
----------------------------------------------------------------
opt.autowrite = true -- Enable auto write
opt.backup = false -- don't use backup files
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.completeopt = "menu,menuone,noselect"
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.formatoptions = "jcroqlnt" -- tcqj
opt.history = 1000 -- store the last 1000 commands entered
opt.inccommand = "nosplit" -- preview incremental substitute
opt.mouse = "a" -- set mouse mode to all modes
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
opt.spelllang = { "en" }
opt.swapfile = false -- don't create swap files for new buffers
opt.textwidth = 120 -- after configured number of characters, wrap line
opt.undofile = true
opt.undolevels = 10000
opt.updatecount = 0 -- don't write swap files after some number of updates
opt.writebackup = false -- don't backup the file while editing

opt.backspace = {
    "eol,start",
    "indent",
} -- make backspace behave in a sane manner

opt.backupdir = {
    "~/.vim-tmp",
    "~/.tmp",
    "~/tmp",
    "/var/tmp",
    "/tmp",
}

opt.directory = {
    "~/.vim-tmp",
    "~/.tmp",
    "~/tmp",
    "/var/tmp",
    "/tmp",
}

-- Searching
opt.hlsearch = true -- highlight search results
opt.ignorecase = true -- case insensitive searching
opt.incsearch = true -- set incremental search, like modern browsers
opt.lazyredraw = false -- don't redraw while executing macros
opt.magic = true -- set magic on, for regular expressions
opt.smartcase = true -- case-sensitive if expresson contains a capital letter

-- Use that as a grepper if ripgrep installed
if vim.fn.executable("rg") then
    opt.grepformat = "%f:%l:%c:%m"
    opt.grepprg = "rg --vimgrep"
end

-- Error bells
opt.errorbells = false
opt.timeoutlen = 300
opt.visualbell = true

-- Appearance
---------------------------------------------------------
opt.autoindent = true -- automatically set indent of new line
opt.cmdheight = 0 -- hide command bar when not used
opt.conceallevel = 3 -- Hide * markup for bold and italic
opt.cursorline = true -- Enable highlighting of the current line
opt.diffopt:append("algorithm:patience")
opt.diffopt:append("hiddenoff")
opt.diffopt:append("internal")
opt.diffopt:append("iwhite")
opt.diffopt:append("vertical")
opt.hidden = true -- current buffer can be put into background
opt.laststatus = 0
opt.linebreak = true -- set soft wrapping
opt.mat = 2 -- how many tenths of a second to blink
opt.number = true -- show line numbers
opt.relativenumber = true -- Relative line numbers
opt.scrolloff = 4 -- Lines of context
opt.shell = vim.env.SHELL
opt.shortmess:append({ W = true, I = true, c = true })
opt.showbreak = "↪"
opt.showcmd = true -- show incomplete commands
opt.showmatch = true -- show matching braces
opt.showmode = false -- Dont show mode since we have a statusline
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartindent = true -- Insert indents automatically
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.termguicolors = true -- True color support
opt.title = true -- set terminal title
opt.ttyfast = true -- faster redrawing
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.wildmenu = true -- enhanced command line completion
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false -- Disable line wrap
opt.wrapmargin = 8 -- wrap lines when coming within n characters from side

-- Tab control
opt.expandtab = true -- Use spaces instead of tabs
opt.shiftround = true -- round indent to a multiple of 'shiftwidth'
opt.shiftwidth = 4 -- number of spaces to use for indent and unindent
opt.smarttab = true -- tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
opt.softtabstop = 4 -- edit as if the tabs are 4 characters wide
opt.tabstop = 4 -- the visible width of tabs

-- Code folding settings
opt.foldenable = false -- don't fold by default
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 1
opt.foldlevelstart = 99
opt.foldmethod = "expr"
opt.foldnestmax = 10 -- deepest fold is 10 levels

-- Toggle invisible characters
opt.list = true -- Show some invisible characters (tabs...
opt.listchars = {
    tab = "→ ",
    eol = "¬",
    trail = "⋅",
    extends = "❯",
    precedes = "❮",
}

-- Fillchars
opt.fillchars = {
    vert = "│",
    fold = "⠀",
    eob = " ", -- suppress ~ at EndOfBuffer
    --diff = "⣿", -- alternatives = ⣿ ░ ─ ╱
    msgsep = "‾",
    foldopen = "▾",
    foldsep = "│",
    foldclose = "▸",
}

if vim.fn.has("nvim-0.9.0") == 1 then
    opt.splitkeep = "screen"
    opt.shortmess:append({ C = true })
end

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
