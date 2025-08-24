
return {
    {"CRAG666/code_runner.nvim",
        config = function()
            require("code_runner").setup({
                filetype = {
                    python = "python3 -u"
                }
            })
        end,
    },
    { "vim-airline/vim-airline" },
    {
        "nvim-tree/nvim-tree.lua",
        config = function()
            require("nvim-tree").setup()
            vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            ensure_installed = { "lua", "python", "markdown", "markdown_inline" },
            highlight = { enable = true },
        },
    },
}
