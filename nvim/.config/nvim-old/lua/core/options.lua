
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = false
vim.opt.autoindent = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.syntax = "on"
vim.opt.cmdheight = 2
vim.opt.scrolloff = 8
vim.opt.cursorline = true
vim.opt.cursorcolumn = true

vim.api.nvim_create_autocmd("InsertEnter", {
    callback = function()
        vim.opt.cursorline = true
        vim.opt.cursorcolumn = true
    end,
})
vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function()
        vim.opt.cursorline = false
        vim.opt.cursorcolumn = false
    end,
})

-- lua/options.lua

-- Configurações gerais
-- ...

-- Configurações de diagnóstico do LSP
vim.diagnostic.config({
  virtual_text = true,      -- Mostra o erro como texto flutuante ao lado do código
  signs = true,             -- Mostra símbolos na lateral
  update_in_insert = false, -- Não mostra erro enquanto digita
  underline = true,
  severity_sort = true,     -- Ordena por gravidade
})

