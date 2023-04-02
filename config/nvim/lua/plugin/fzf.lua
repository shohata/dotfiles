local function floating_fzf()
    local lines = vim.o.lines
    local columns = vim.o.columns
    local buf = vim.api.nvim_create_buf(true, true)
    local height = vim.fn.float2nr(lines * 0.5)
    local width = vim.fn.float2nr(columns * 0.7)
    local horizontal = vim.fn.float2nr((columns - width) / 2)
    local vertical = 0
    local opts = {
        relative = "editor",
        row = vertical,
        col = horizontal,
        width = width,
        height = height,
        style = "minimal"
    }
    vim.api.nvim_open_win(buf, true, opts)
end
-- _G makes this function available to vimscript lua calls
_G.floating_fzf = floating_fzf

local function init()
    local fzf_opts = {
        vim.env.FZF_DEFAULT_OPTS or "",
        "--layout=reverse",
        "--pointer=\" \"",
        "--info=hidden",
        "--border=rounded",
        "--bind å:select-all+accept"
    }

    vim.env.FZF_DEFAULT_OPTS = table.concat(fzf_opts, " ")

    vim.g.fzf_preview_window = {
        "right:50%:hidden",
        "?"
    }
    vim.g.fzf_layout = {
        window = "call v:lua.floating_fzf()"
    }

    local fzf_cmd = {
        "command! FZFMru call fzf#run({'source': v:oldfiles,'sink': 'e', 'options': '-m -x +s', 'down': '40%'})",
        "command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --follow --color=always '.<q-args>.' || true', 1, <bang>0 ? fzf#vim#with_preview('up:60%') : fzf#vim#with_preview('right:50%:hidden', '?'), <bang>0)",
        "command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)",
        "command! -bang -nargs=? -complete=dir GitFiles call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview(), <bang>0)"
    }

    for k, v in pairs(fzf_cmd) do
        vim.cmd(v)
    end
end

-- Insert mode completion
local keys = {
    {
        "<c-x><c-k>",
        "<Plug>(fzf-complete-word)",
        mode = "i"
    },
    {
        "<c-x><c-f>",
        "<Plug>(fzf-complete-path)",
        mode = "i"
    },
    {
        "<c-x><c-j>",
        "<Plug>(fzf-complete-file-ag)",
        mode = "i"
    },
    {
        "<c-x><c-l>",
        "<Plug>(fzf-complete-line)",
        mode = "i"
    }
}

return {
    init = init,
    keys = keys
}
