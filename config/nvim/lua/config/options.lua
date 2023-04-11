-- This file is automatically loaded by plugins.config

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

-- General
----------------------------------------------------------------
opt.autowrite = true -- Enable auto write
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.backup = false -- don't use backup files
opt.writebackup = false -- don't backup the file while editing
opt.swapfile = false -- don't create swap files for new buffers
opt.updatecount = 0 -- don't write swap files after some number of updates
opt.undofile = true
opt.undolevels = 10000
opt.spelllang = { "en" }
opt.formatoptions = "jcroqlnt" -- tcqj
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }

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

opt.history = 1000 -- store the last 1000 commands entered
opt.textwidth = 120 -- after configured number of characters, wrap line

opt.inccommand = "nosplit" -- preview incremental substitute

opt.backspace = {
    "indent",
    "eol,start",
} -- make backspace behave in a sane manner
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.mouse = "a" -- set mouse mode to all modes

-- Searching
opt.ignorecase = true -- case insensitive searching
opt.smartcase = true -- case-sensitive if expresson contains a capital letter
opt.hlsearch = true -- highlight search results
opt.incsearch = true -- set incremental search, like modern browsers
opt.lazyredraw = false -- don't redraw while executing macros
opt.magic = true -- set magic on, for regular expressions

-- Use that as a grepper if ripgrep installed
if vim.fn.executable("rg") then
    opt.grepformat = "%f:%l:%c:%m"
    opt.grepprg = "rg --vimgrep"
end

-- Error bells
opt.errorbells = false
opt.visualbell = true
opt.timeoutlen = 300

-- Appearance
---------------------------------------------------------
opt.conceallevel = 3 -- Hide * markup for bold and italic
opt.cursorline = true -- Enable highlighting of the current line
opt.termguicolors = true -- True color support
opt.number = true -- show line numbers
opt.relativenumber = true -- Relative line numbers
opt.wrap = false -- Disable line wrap
opt.wrapmargin = 8 -- wrap lines when coming within n characters from side
opt.linebreak = true -- set soft wrapping
opt.showbreak = "↪"
opt.autoindent = true -- automatically set indent of new line
opt.smartindent = true -- Insert indents automatically
opt.ttyfast = true -- faster redrawing
table.insert(opt.diffopt, "vertical")
table.insert(opt.diffopt, "iwhite")
table.insert(opt.diffopt, "internal")
table.insert(opt.diffopt, "algorithm:patience")
table.insert(opt.diffopt, "hiddenoff")
opt.laststatus = 0
opt.scrolloff = 4 -- Lines of context
opt.sidescrolloff = 8 -- Columns of context
opt.wildmenu = true -- enhanced command line completion
opt.hidden = true -- current buffer can be put into background
opt.showcmd = true -- show incomplete commands
opt.showmode = false -- Dont show mode since we have a statusline
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.shell = vim.env.SHELL
opt.cmdheight = 0 -- hide command bar when not used
opt.title = true -- set terminal title
opt.showmatch = true -- show matching braces
opt.mat = 2 -- how many tenths of a second to blink
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.shortmess:append({ W = true, I = true, c = true })
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.winminwidth = 5 -- Minimum window width

-- Tab control
opt.expandtab = true -- Use spaces instead of tabs
opt.smarttab = true -- tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
opt.tabstop = 4 -- the visible width of tabs
opt.softtabstop = 4 -- edit as if the tabs are 4 characters wide
opt.shiftwidth = 4 -- number of spaces to use for indent and unindent
opt.shiftround = true -- round indent to a multiple of 'shiftwidth'

-- Code folding settings
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevelstart = 99
opt.foldnestmax = 10 -- deepest fold is 10 levels
opt.foldenable = false -- don't fold by default
opt.foldlevel = 1

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

-- Do sync format when doing :wq because default formatting is async
-- vim.cmd([[cabbrev wq execute "Format sync" <bar> wq]])
