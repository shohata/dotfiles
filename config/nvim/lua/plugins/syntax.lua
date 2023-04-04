---------------------------------------------------------
-- Syntax
---------------------------------------------------------

return {
    {
        -- syntax for docker
        "ekalinin/Dockerfile.vim",
        ft = "Dockerfile",
    },
    {
        -- syntax for markdown
        "preservim/vim-markdown",
        ft = "markdown",
        dependencies = { "godlygeek/tabular" },
    },
}
