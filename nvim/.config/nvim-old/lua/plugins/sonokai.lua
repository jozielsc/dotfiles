
return {
    "sainnhe/sonokai",
    priority = 1000,
    lazy = false,
    config = function()
        vim.g.sonokai_style = "andromeda"
        vim.g.sonokai_enable_italic = 1
        vim.g.sonokai_enable_italic_comment = 1
        vim.g.sonokai_diagnostic_line_highlight = 1
        vim.g.sonokai_better_performance = 1
        vim.g["airline#extensions#tabline#enable"] = 1
        vim.g["airline#extensions#formatter"] = "unique_tail"
        vim.g.airline_theme = "sonokai"
        vim.g.airline_powerline_fonts = 1
        vim.cmd.colorscheme("sonokai")
    end
}
