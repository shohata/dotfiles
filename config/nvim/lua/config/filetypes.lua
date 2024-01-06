-- https://neovim.io/doc/user/lua.html#lua-filetype

vim.filetype.add({
    filename = {
        ["Brewfile"] = "ruby",
    },
    pattern = {
        [".*/ssh/config"] = "ssh_config",
        ["{HOME}/.ssh/config"] = "ssh_config",
    },
})
