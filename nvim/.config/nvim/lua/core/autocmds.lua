
vim.api.nvim_create_autocmd("BufRead", {
    pattern = "*.qmd",
    callback = function()
        vim.g.quarto_enabled = true
    end,
})

