return {
    'akinsho/bufferline.nvim', 
    version="*", 
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        require("bufferline").setup({
            options= {
                numbers="ordinal",
                diagnostics="nvim_lsp",
                show_close_icon=false,
                show_buffer_close_icons=false,
                separator_style= "splant",
            }
        })
        vim.opt.termguicolors = true
    end,
}
